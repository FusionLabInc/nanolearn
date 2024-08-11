package auth

import (
	"github.com/FusionLabInc/nanolearn/gateway-service/bootstrap"
	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/llm/routes"
	"github.com/gin-gonic/gin"
)

func RegisterRoutes(r *gin.Engine, env *bootstrap.Env) *ServiceClient {
	svc := &ServiceClient{
		Client: InitServiceClient(env),
	}

	routes := r.Group("/llm")
	routes.POST("/nickname/generate", svc.FetchSetupNicknamePool)

	return svc
}

func (svc *ServiceClient) FetchSetupNicknamePool(ctx *gin.Context) {
	routes.GenerateNickname(ctx, svc.Client)
}
