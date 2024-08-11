package routes

import (
	"context"
	"net/http"

	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/backend/pb"
	"github.com/FusionLabInc/nanolearn/gateway-service/utils/api_response"
	"github.com/gin-gonic/gin"
)

type LoginRequestBody struct {
	Nickname string `json:"nickname"`
}

func Login(ctx *gin.Context, c pb.BackendServiceClient) {

	reqBody := LoginRequestBody{}

	if err := ctx.BindJSON(&reqBody); err != nil {
		ctx.JSON(http.StatusBadRequest, api_response.BaseErrorResponse(err.Error()))
		return
	}

	res, _ := c.Login(context.Background(), &pb.LoginRequest{
		Nickname: reqBody.Nickname,
	})

	api_response.Respond(ctx, res)

}
