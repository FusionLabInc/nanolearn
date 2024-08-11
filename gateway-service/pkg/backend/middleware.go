package backend

import (
	"context"
	"net/http"
	"strings"

	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/backend/pb"
	"github.com/gin-gonic/gin"
	"google.golang.org/grpc/codes"
)

type AuthMiddlewareConfig struct {
	svc *ServiceClient
}

func InitAuthMiddleware(svc *ServiceClient) AuthMiddlewareConfig {
	return AuthMiddlewareConfig{svc}
}

func (c *AuthMiddlewareConfig) AuthRequired(ctx *gin.Context) {
	authorizationHeader := ctx.Request.Header.Get("token")

	if authorizationHeader == "" {
		ctx.JSON(http.StatusUnauthorized, gin.H{})
		return
	}

	token := strings.Split(authorizationHeader, "Bearer ")

	if len(token) < 2 {
		ctx.JSON(http.StatusUnauthorized, gin.H{})
		return
	}

	res, _ := c.svc.Client.ValidateToken(context.Background(), &pb.ValidateTokenRequest{
		AccessToken: token[1],
	})

	if res.Code != int64(codes.OK) {
		ctx.JSON(http.StatusUnauthorized, gin.H{})
		return
	}

	ctx.Set("userId", res.UserId)

	ctx.Next()
}
