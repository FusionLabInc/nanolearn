package gapi

import (
	"io"
	"log"

	"github.com/FusionLabInc/nanolearn/llm-service/pb"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func (s *Server) GenerateNickname(stream pb.LlmService_GenerateNicknameServer) error {

	for {
		message, err := stream.Recv()

		if err == io.EOF {
			// The client has closed the connection.
			break
		}
		if err != nil {
			return status.Errorf(codes.Internal, "Error receiving message: %v", err)
		}

		// message.SelectedNicknamesFromPool

		generatedNickname := s.Repository.Setup.GenerateNickname(stream.Context(), message.SelectedNicknamesFromPool, *s.Env)

		response := &pb.GenerateNicknameResponse{
			Nickname: *generatedNickname,
		}
		if err := stream.Send(response); err != nil {
			log.Printf("Error sending confirmation message: %v", err)
		}

	}

	return nil

}
