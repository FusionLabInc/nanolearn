package routes

import (
	"io"
	"log"
	"net/http"
	"os"
	"path/filepath"

	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/llm/pb"
	"github.com/FusionLabInc/nanolearn/gateway-service/utils/api_response"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

const (
	batchSize = 1024 * 1024
)

type File struct {
	Id       string `json:"id"`
	Filename string `json:"file_name"`
}

func NanoContent(ctx *gin.Context, c pb.LlmServiceClient) {

	userId, _ := ctx.Get("userId")

	file, err := ctx.FormFile("file")
	if err != nil {
		ctx.JSON(http.StatusBadRequest, api_response.BaseErrorResponse(err.Error()))
		return
	}
	filePath := filepath.Join("uploads", file.Filename)
	if err := ctx.SaveUploadedFile(file, filePath); err != nil {
		ctx.JSON(http.StatusInternalServerError, api_response.BaseErrorResponse("Failed to save file"))
		return
	}

	uuid := uuid.New().String()

	stream, err := c.NanoContent(ctx)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, api_response.BaseErrorResponse(err.Error()))
		return
	}

	downloadedFile, err := os.Open(filePath)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, api_response.BaseErrorResponse(err.Error()))
		return
	}

	buf := make([]byte, batchSize)
	batchNumber := 1
	for {
		num, err := downloadedFile.Read(buf)
		if err == io.EOF {
			break
		}
		if err != nil {
			ctx.JSON(http.StatusInternalServerError, api_response.BaseErrorResponse(err.Error()))
			return
		}
		chunk := buf[:num]

		if err := stream.Send(&pb.NanoContentRequest{FileName: file.Filename, Id: uuid, UserId: userId.(string), Chunk: chunk}); err != nil {
			ctx.JSON(http.StatusInternalServerError, api_response.BaseErrorResponse(err.Error()))
			return
		}
		log.Printf("Sent - batch #%v - size - %v\n", batchNumber, len(chunk))
		batchNumber += 1

	}
	res, err := stream.CloseAndRecv()
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, api_response.BaseErrorResponse(err.Error()))
		return
	}
	log.Printf("Sent - %v bytes - %s\n", res.GetSize(), res.GetFileName())

	api_response.Respond(ctx, &pb.NanoContentResponse{
		FileName: file.Filename,
		Size:     res.GetSize(),
	})

}
