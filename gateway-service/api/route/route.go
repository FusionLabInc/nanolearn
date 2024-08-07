package route

import (
	"time"

	"github.com/FusionLabInc/nanolearn/gateway-service/bootstrap"
	backend "github.com/FusionLabInc/nanolearn/gateway-service/pkg/backend"
	"github.com/gin-gonic/gin"
)

func Setup(env *bootstrap.Env, timeout time.Duration, gin *gin.Engine) {

	// Backend Service
	backend.RegisterRoutes(gin, env)

}
