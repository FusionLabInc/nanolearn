package main

import (
	"log"
	"net"
	"time"

	"github.com/FusionLabInc/nanolearn/backend-service/bootstrap"
	"github.com/FusionLabInc/nanolearn/backend-service/domain"
	"github.com/FusionLabInc/nanolearn/backend-service/gapi"
	"github.com/FusionLabInc/nanolearn/backend-service/pb"
	"github.com/FusionLabInc/nanolearn/backend-service/repository"
	"github.com/FusionLabInc/nanolearn/backend-service/utils/logger"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

const (
	contextTimeout = 10
)

func main() {

	app := bootstrap.App()

	env := app.Env

	timeout := time.Duration(contextTimeout) * time.Second

	ur := repository.NewUserRepository(app.Db)

	repository := domain.Repository{
		User: ur,
	}

	server, err := gapi.NewServer(env, *app.Db, repository, timeout)
	if err != nil {
		log.Fatal("Cannot create server :", err)
	}

	gprcLogger := grpc.UnaryInterceptor(logger.GrpcLogger)

	grpcServer := grpc.NewServer(gprcLogger)

	pb.RegisterBackendServiceServer(grpcServer, server)

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
