package gapi

import (
	"context"
	"fmt"

	"github.com/FusionLabInc/nanolearn/backend-service/utils/api_response"

	"github.com/FusionLabInc/nanolearn/backend-service/pb"
)

func (s *Server) ValidateToken(ctx context.Context, req *pb.ValidateTokenRequest) (*pb.ValidateTokenResponse, error) {

	payload, err := s.TokenMaker.VerifyToken(
		req.AccessToken,
	)

	if err != nil {
		return api_response.ErrorInternal(&pb.ValidateTokenResponse{}, fmt.Sprintf("Failed to verify token: %s", err)).(*pb.ValidateTokenResponse), nil
	}

	return api_response.Success(&pb.ValidateTokenResponse{}, "User successfully validated", map[string]interface{}{
		"user_id": payload.Username,
	}).(*pb.ValidateTokenResponse), nil

}
