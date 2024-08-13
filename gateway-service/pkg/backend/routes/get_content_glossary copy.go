package routes

import (
	"context"

	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/backend/pb"
	"github.com/FusionLabInc/nanolearn/gateway-service/utils/api_response"
	"github.com/gin-gonic/gin"
)

func GetContentSummaries(ctx *gin.Context, c pb.BackendServiceClient) {

	contentId := ctx.Param("id")

	res, _ := c.GetContentSummaries(context.Background(), &pb.GetContentSummariesRequest{
		ContentId: contentId,
	})

	api_response.Respond(ctx, res)

}
