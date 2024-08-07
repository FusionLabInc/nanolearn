package gapi

// import (
// 	"context"
// 	"fmt"

// 	"github.com/FusionLabInc/nanolearn/backend-service/utils/api_response"

// 	"github.com/FusionLabInc/nanolearn/backend-service/pb"
// )

// func (s *Server) Validate(ctx context.Context, req *pb.ValidateRequest) (*pb.ValidateResponse, error) {

// 	payload, err := s.TokenMaker.VerifyToken(
// 		req.AccessToken,
// 	)

// 	if err != nil {
// 		return api_response.ErrorInternal(&pb.ValidateResponse{}, fmt.Sprintf("Failed to verify token: %s", err)).(*pb.ValidateResponse), nil
// 	}

// 	return api_response.Success(&pb.ValidateResponse{}, "User successfully validated", map[string]interface{}{
// 		"user_id": payload.ID.String(),
// 	}).(*pb.ValidateResponse), nil

// }
