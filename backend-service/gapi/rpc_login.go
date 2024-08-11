package gapi

import (
	"context"
	"fmt"

	"github.com/FusionLabInc/nanolearn/backend-service/repository"
	"github.com/FusionLabInc/nanolearn/backend-service/usecase"
	"github.com/FusionLabInc/nanolearn/backend-service/utils/api_response"

	"github.com/FusionLabInc/nanolearn/backend-service/pb"
	"github.com/FusionLabInc/nanolearn/backend-service/utils/validator"
)

func (s *Server) Login(ctx context.Context, req *pb.LoginRequest) (*pb.LoginResponse, error) {

	err := validator.ValidateLoginRequest(req)
	if err != nil {
		return api_response.ErrorBadRequest(&pb.LoginResponse{}, err.Error()).(*pb.LoginResponse), nil
	}

	ur := repository.NewUserRepository(s.Db)
	lu := usecase.NewLoginUsecase(ur)

	var userId string

	dbUser := lu.GetUserByUsername(ctx, req.GetNickname())
	if dbUser == nil {
		createRes := lu.Create(ctx, req.GetNickname())

		if createRes == nil {
			return api_response.ErrorInternal(&pb.LoginResponse{}, fmt.Sprintf("Failed to create user: %s", err)).(*pb.LoginResponse), nil
		}

		userId = *createRes

	} else {
		userId = dbUser.ID
	}

	accessToken, accessPayload, err := s.TokenMaker.CreateToken(
		userId,
		s.Env.AccessTokenDuration,
	)

	if err != nil {
		return api_response.ErrorInternal(&pb.LoginResponse{}, fmt.Sprintf("Failed to generate access token: %s", err)).(*pb.LoginResponse), nil
	}

	refreshToken, refreshPayload, err := s.TokenMaker.CreateToken(
		userId,
		s.Env.AccessTokenDuration,
	)

	if err != nil {
		return api_response.ErrorInternal(&pb.LoginResponse{}, fmt.Sprintf("Failed to generate refresh token: %s", err)).(*pb.LoginResponse), nil
	}

	return api_response.Success(&pb.LoginResponse{}, "User successfully logged in", map[string]interface{}{
		"access_token":             accessToken,
		"access_token_expires_at":  accessPayload.ExpiredAt.Unix(),
		"refresh_token":            refreshToken,
		"refresh_token_expires_at": refreshPayload.ExpiredAt.Unix(),
		"user_id":                  userId,
	}).(*pb.LoginResponse), nil

}
