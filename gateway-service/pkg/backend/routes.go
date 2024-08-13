package backend

import (
	"github.com/FusionLabInc/nanolearn/gateway-service/bootstrap"
	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/backend/routes"
	"github.com/gin-gonic/gin"
)

func RegisterRoutes(r *gin.Engine, env *bootstrap.Env) AuthMiddlewareConfig {

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
	userRoutes.POST("/upload", svc.UploadAndNanoContent)
	userRoutes.GET("/summary/:id", svc.GetContentSummaries)
	userRoutes.GET("/glossary/:id", svc.GetContentGlossary)

	return a
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

func (svc *ServiceClient) UploadAndNanoContent(ctx *gin.Context) {
	routes.UploadAndNanoContent(ctx, svc.Client)
}

func (svc *ServiceClient) GetContentSummaries(ctx *gin.Context) {
	routes.GetContentSummaries(ctx, svc.Client)
}

func (svc *ServiceClient) GetContentGlossary(ctx *gin.Context) {
	routes.GetContentGlossary(ctx, svc.Client)
}
