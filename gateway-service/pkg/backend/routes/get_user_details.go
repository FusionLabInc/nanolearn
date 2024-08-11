package routes

import (
	"context"

	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/backend/pb"
	"github.com/FusionLabInc/nanolearn/gateway-service/utils/api_response"
	"github.com/gin-gonic/gin"
)

func GetUserDetails(ctx *gin.Context, c pb.BackendServiceClient) {

	userId, _ := ctx.Get("userId")

	res, _ := c.GetUserDetails(context.Background(), &pb.GetUserDetailsRequest{
		UserId: userId.(string),
	})

	api_response.Respond(ctx, res)

}
