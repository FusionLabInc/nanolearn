package backend

import (
	"github.com/FusionLabInc/nanolearn/gateway-service/bootstrap"
	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/backend/routes"
	"github.com/gin-gonic/gin"
)

func RegisterRoutes(r *gin.Engine, env *bootstrap.Env) *ServiceClient {

	svc := &ServiceClient{
		Client: InitServiceClient(env),
	}

	a := InitAuthMiddleware(svc)

	routes := r.Group("/backend")
	routes.GET("/nicknames/pool", svc.FetchSetupNicknamePool)
	routes.POST("/login", svc.Login)

	userRoutes := r.Group("/backend/user")
	userRoutes.Use(a.AuthRequired)
	userRoutes.GET("", svc.GetUserDetails)

	return svc
}

func (svc *ServiceClient) FetchSetupNicknamePool(ctx *gin.Context) {
	routes.FetchSetupNicknamePool(ctx, svc.Client)
}

func (svc *ServiceClient) Login(ctx *gin.Context) {
	routes.Login(ctx, svc.Client)
}

func (svc *ServiceClient) GetUserDetails(ctx *gin.Context) {
	routes.GetUserDetails(ctx, svc.Client)
}
