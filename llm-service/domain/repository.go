package domain

import "github.com/FusionLabInc/nanolearn/llm-service/repository"

type Repository struct {
	Setup   repository.SetupRepository
	Content repository.ContentRepository
	User    repository.UserRepository
}
