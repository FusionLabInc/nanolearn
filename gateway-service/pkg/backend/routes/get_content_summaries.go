package routes

import (
	"context"

	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/backend/pb"
	"github.com/FusionLabInc/nanolearn/gateway-service/utils/api_response"
	"github.com/gin-gonic/gin"
)

func GetContentGlossary(ctx *gin.Context, c pb.BackendServiceClient) {

	contentId := ctx.Param("id")

	res, _ := c.GetContentGlossary(context.Background(), &pb.GetContentGlossaryRequest{
		ContentId: contentId,
	})

	api_response.Respond(ctx, res)

}
