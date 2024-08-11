package gapi

import (
	"context"

	"github.com/FusionLabInc/nanolearn/backend-service/repository"
	"github.com/FusionLabInc/nanolearn/backend-service/usecase"
	"github.com/FusionLabInc/nanolearn/backend-service/utils/api_response"

	"github.com/FusionLabInc/nanolearn/backend-service/pb"
)

func (s *Server) GetUserDetails(ctx context.Context, req *pb.GetUserDetailsRequest) (*pb.GetUserDetailsResponse, error) {

	ur := repository.NewUserRepository(s.Db)
	lu := usecase.NewLoginUsecase(ur)

	userId := req.GetUserId()

	dbUser := lu.GetUserById(ctx, userId)
	if dbUser == nil {
		return api_response.ErrorBadRequest(&pb.GetUserDetailsResponse{}, "Unable to fetch user details").(*pb.GetUserDetailsResponse), nil

	}

	return api_response.Success(&pb.GetUserDetailsResponse{}, "User successfully fethed", map[string]interface{}{
		"user_id":    userId,
		"created_at": dbUser.CreatedAt,
		"username":   dbUser.Username,
	}).(*pb.GetUserDetailsResponse), nil

}
