package routes

import (
	"context"
	"fmt"
	"io"
	"log"
	"net/http"

	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/llm/pb"
	"github.com/FusionLabInc/nanolearn/gateway-service/utils/api_response"
	"github.com/gin-gonic/gin"
)

type GenerateNicknameBody struct {
	NicknamesFromPool []string `json:"nicknames_from_pool"`
}

func GenerateNickname(ctx *gin.Context, c pb.LlmServiceClient) {

	reqBody := GenerateNicknameBody{}

	if err := ctx.BindJSON(&reqBody); err != nil {
		ctx.JSON(http.StatusBadRequest, api_response.BaseErrorResponse(err.Error()))
		return
	}

	stream, _ := c.GenerateNickname(context.Background())

	waitResponse := make(chan error)

	go func() {
		for {
			res, err := stream.Recv()
			if err == io.EOF {
				log.Print("no more responses")
				waitResponse <- nil
				return
			}
			if err != nil {
				waitResponse <- fmt.Errorf("cannot receive stream response: %v", err)
				return
			}

			log.Print("received response: ", res)

			api_response.Respond(ctx, res)
		}
	}()

	// send requests
	req := &pb.GenerateNicknameRequest{
		SelectedNicknamesFromPool: reqBody.NicknamesFromPool,
	}

	err := stream.Send(req)
	if err != nil {
		fmt.Printf("cannot send stream request: %v - %v", err, stream.RecvMsg(nil))

		api_response.Respond(ctx, &pb.GenerateNicknameResponse{
			Nickname: err.Error(),
		})
		return
	}

	log.Print("sent request: ", req)

	err = stream.CloseSend()
	if err != nil {
		fmt.Printf("cannot close send: %v", err)

		api_response.Respond(ctx, &pb.GenerateNicknameResponse{
			Nickname: err.Error(),
		})
		return
	}

	err = <-waitResponse
	api_response.Respond(ctx, &pb.GenerateNicknameResponse{
		Nickname: err.Error(),
	})

}
