package auth

import (
	"github.com/FusionLabInc/nanolearn/gateway-service/bootstrap"
	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/backend/routes"
	"github.com/gin-gonic/gin"
)

func RegisterRoutes(r *gin.Engine, env *bootstrap.Env) *ServiceClient {
	svc := &ServiceClient{
		Client: InitServiceClient(env),
	}

	routes := r.Group("/backend")
	routes.GET("/nicknames", svc.FetchSetupNicknamePool)
	// routes.POST("/login", svc.Login)
	// routes.POST("/token", svc.RenewToken)

	return svc
}

func (svc *ServiceClient) FetchSetupNicknamePool(ctx *gin.Context) {
	routes.FetchSetupNicknamePool(ctx, svc.Client)
}
