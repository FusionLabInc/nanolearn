package usecase

import (
	"context"

	"github.com/FusionLabInc/nanolearn/backend-service/domain"
	"github.com/FusionLabInc/nanolearn/backend-service/repository"
	"github.com/FusionLabInc/nanolearn/backend-service/utils/methods"
)

type loginUsecase struct {
	userRepository repository.UserRepository
}

type LoginUsecase interface {
	Create(ctx context.Context, username string) *string
	GetUserByUsername(ctx context.Context, username string) *domain.User
	GetUserById(ctx context.Context, userId string) *domain.User
}

func NewLoginUsecase(userRepository repository.UserRepository) LoginUsecase {
	return &loginUsecase{
		userRepository: userRepository,
	}
}

func (ru *loginUsecase) Create(ctx context.Context, username string) *string {

	encodedUsername := methods.Base64Encode(username)

	res := ru.userRepository.Add(ctx, encodedUsername, domain.User{
		ID:        encodedUsername,
		Username:  username,
		CreatedAt: methods.GetCurrentTimestamp(),
	})

	if res {

		return &encodedUsername
	}

	return nil
}

func (ru *loginUsecase) GetUserByUsername(ctx context.Context, username string) *domain.User {
	encodedUsername := methods.Base64Encode(username)
	return ru.userRepository.Get(ctx, encodedUsername)
}

func (ru *loginUsecase) GetUserById(ctx context.Context, userId string) *domain.User {
	return ru.userRepository.Get(ctx, userId)
}
