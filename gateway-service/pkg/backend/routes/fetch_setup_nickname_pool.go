package routes

import (
	"context"

	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/backend/pb"
	"github.com/FusionLabInc/nanolearn/gateway-service/utils/api_response"
	"github.com/gin-gonic/gin"
)

func FetchSetupNicknamePool(ctx *gin.Context, c pb.BackendServiceClient) {

	res, _ := c.FetchSetupNicknamePool(context.Background(), &pb.FetchSetupNicknamePoolRequest{})

	api_response.Respond(ctx, res)

}
