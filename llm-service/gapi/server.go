package gapi

import (
	"fmt"
	"log"
	"time"

	"github.com/FusionLabInc/nanolearn/llm-service/bootstrap"
	"github.com/FusionLabInc/nanolearn/llm-service/domain"
	"github.com/FusionLabInc/nanolearn/llm-service/pb"
	"github.com/FusionLabInc/nanolearn/llm-service/utils/token"
)

type Server struct {
	pb.UnimplementedLlmServiceServer
	Llm        *bootstrap.Llm
	TokenMaker token.Maker
	Env        *bootstrap.Env
	Timeout    time.Duration
	Repository domain.Repository
}

// NewServer creates a new gRPC server
func NewServer(env *bootstrap.Env, llm *bootstrap.Llm, r domain.Repository, timeout time.Duration) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(env.TokenSymmetricKey)

	if err != nil {
		log.Fatal("Cannot create token maker: ", err)
		return nil, fmt.Errorf("Cannot create token maker: %w", err)
	}

	server := &Server{
		Llm:        llm,
		TokenMaker: tokenMaker,
		Env:        env,
		Timeout:    timeout,
		Repository: r,
	}

	return server, nil
}
