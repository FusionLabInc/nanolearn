package auth

import (
	"fmt"

	"github.com/FusionLabInc/nanolearn/gateway-service/bootstrap"
	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/llm/pb"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

type ServiceClient struct {
	Client pb.LlmServiceClient
}

func InitServiceClient(env *bootstrap.Env) pb.LlmServiceClient {

	var transportOption grpc.DialOption

	transportOption = grpc.WithTransportCredentials(insecure.NewCredentials())

	cc, err := grpc.NewClient(env.LlmServerUrl, transportOption)

	if err != nil {
		fmt.Println("Could not connect:", err)
	}

	return pb.NewLlmServiceClient(cc)
}
