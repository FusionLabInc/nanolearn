package main

import (
	"log"
	"net"
	"time"

	"github.com/FusionLabInc/nanolearn/llm-service/bootstrap"
	"github.com/FusionLabInc/nanolearn/llm-service/domain"
	"github.com/FusionLabInc/nanolearn/llm-service/gapi"
	"github.com/FusionLabInc/nanolearn/llm-service/pb"
	"github.com/FusionLabInc/nanolearn/llm-service/repository"
	"github.com/FusionLabInc/nanolearn/llm-service/utils/logger"
	"github.com/unidoc/unipdf/v3/common/license"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

const (
	contextTimeout = 10
)

func main() {

	app := bootstrap.App()

	env := app.Env

	err := license.SetMeteredKey(env.UnidocApiKey)
	if err != nil {
		panic(err)
	}

	timeout := time.Duration(contextTimeout) * time.Second

	sr := repository.NewSetupRepository(app.Llm)

	cr := repository.NewContentRepository(app.Llm, app.Db)

	ur := repository.NewUserRepository(app.Db)

	repository := domain.Repository{
		Setup:   sr,
		Content: cr,
		User:    ur,
	}

	server, err := gapi.NewServer(env, app.Llm, repository, timeout)
	if err != nil {
		log.Fatal("Cannot create server :", err)
	}

	grpcServer := grpc.NewServer(
		grpc.UnaryInterceptor(logger.GrpcLogger),
		grpc.StreamInterceptor(logger.GrpcLoggerStream))

	pb.RegisterLlmServiceServer(grpcServer, server)

	reflection.Register(grpcServer)

	listener, err := net.Listen("tcp", env.AppServerUrl)
	if err != nil {
		log.Fatal("Cannot create listener :", err)
	}

	log.Printf("Starting gRPC server at %s", listener.Addr().String())

	err = grpcServer.Serve(listener)

	if err != nil {
		log.Fatal("Cannot start gRPC server :", err)
	}

}
