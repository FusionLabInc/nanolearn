package gapi

import (
	"context"
	"fmt"
	"io"
	"path/filepath"

	"github.com/FusionLabInc/nanolearn/backend-service/pb"
	"github.com/FusionLabInc/nanolearn/backend-service/utils/file"
)

const (
	uploadPath = "users_content/"
)

func (s *Server) UploadFile(stream pb.BackendService_UploadFileServer) error {

	file := file.NewFile()
	var fileSize uint32
	fileSize = 0
	var userId string
	defer func() {
		if err := file.OutputFile.Close(); err != nil {
			fmt.Println(err.Error())
		}
	}()
	for {
		req, err := stream.Recv()
		if file.FilePath == "" {
			file.SetFile(req.GetFileName(), uploadPath)
			userId = req.GetUserId()
		}
		if err == io.EOF {
			break
		}
		if err != nil {
			fmt.Println(err.Error())
			return err
		}
		chunk := req.GetChunk()
		fileSize += uint32(len(chunk))
		fmt.Printf("received a chunk with size: %d", fileSize)
		if err := file.Write(chunk); err != nil {
			fmt.Println(err.Error())
			return err
		}
	}
	fileName := filepath.Base(file.FilePath)

	fmt.Print(file.OutputFile)

	// UPLOAD FILE TO FIREBASE STORAGE
	wc := s.Storage.Client.Bucket(s.Env.StorageBucketUrl).Object(uploadPath + userId + "/" + fileName).NewWriter(context.Background())
	if _, err := io.Copy(wc, file.OutputFile); err != nil {
		return fmt.Errorf("io.Copy: %v", err)
	}

	defer wc.Close()

	if err := wc.Close(); err != nil {
		return fmt.Errorf("Writer.Close: %v", err)
	}
	fmt.Printf("saved file: %s, size: %d", fileName, fileSize)
	return stream.SendAndClose(&pb.FileUploadResponse{FileName: fileName, Size: fileSize})

}
