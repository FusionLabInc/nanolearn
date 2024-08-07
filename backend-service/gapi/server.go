package gapi

import (
	"fmt"
	"log"
	"time"

	"github.com/FusionLabInc/nanolearn/backend-service/bootstrap"
	"github.com/FusionLabInc/nanolearn/backend-service/domain"
	"github.com/FusionLabInc/nanolearn/backend-service/pb"
	"github.com/FusionLabInc/nanolearn/backend-service/utils/token"
)

type Server struct {
	pb.UnimplementedBackendServiceServer
	Db         bootstrap.Database
	TokenMaker token.Maker
	Env        *bootstrap.Env
	Timeout    time.Duration
	Repository domain.Repository
}

// NewServer creates a new gRPC server
func NewServer(env *bootstrap.Env, db bootstrap.Database, r domain.Repository, timeout time.Duration) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(env.TokenSymmetricKey)

	if err != nil {
		log.Fatal("Cannot create token maker: ", err)
		return nil, fmt.Errorf("Cannot create token maker: %w", err)
	}

	server := &Server{
		Db:         db,
		TokenMaker: tokenMaker,
		Env:        env,
		Timeout:    timeout,
		Repository: r,
	}

	return server, nil
}
