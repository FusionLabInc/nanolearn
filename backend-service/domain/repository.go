package domain

import "github.com/FusionLabInc/nanolearn/backend-service/repository"

type Repository struct {
	User repository.UserRepository
}
