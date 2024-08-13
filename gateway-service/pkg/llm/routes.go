package llm

import (
	"github.com/FusionLabInc/nanolearn/gateway-service/bootstrap"
	backend "github.com/FusionLabInc/nanolearn/gateway-service/pkg/backend"
	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/llm/routes"
	"github.com/gin-gonic/gin"
)

func RegisterRoutes(r *gin.Engine, env *bootstrap.Env, a backend.AuthMiddlewareConfig) *ServiceClient {
	svc := &ServiceClient{
		Client: InitServiceClient(env),
	}

	routes := r.Group("/llm")
	routes.POST("/nickname/generate", svc.GenerateNickname)
	routes.Use(a.AuthRequired)
	routes.POST("/content/generate", svc.NanoContent)

	return svc
}

func (svc *ServiceClient) GenerateNickname(ctx *gin.Context) {
	routes.GenerateNickname(ctx, svc.Client)
}

func (svc *ServiceClient) NanoContent(ctx *gin.Context) {
	routes.NanoContent(ctx, svc.Client)
}
