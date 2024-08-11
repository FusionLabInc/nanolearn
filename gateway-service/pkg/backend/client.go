package backend

import (
	"fmt"

	"github.com/FusionLabInc/nanolearn/gateway-service/bootstrap"
	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/backend/pb"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

type ServiceClient struct {
	Client pb.BackendServiceClient
}

func InitServiceClient(env *bootstrap.Env) pb.BackendServiceClient {

	var transportOption grpc.DialOption

	transportOption = grpc.WithTransportCredentials(insecure.NewCredentials())

	cc, err := grpc.NewClient(env.BackendServerUrl, transportOption)

	if err != nil {
		fmt.Println("Could not connect:", err)
	}

	return pb.NewBackendServiceClient(cc)
}
