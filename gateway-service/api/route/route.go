package route

import (
	"time"

	"github.com/FusionLabInc/nanolearn/gateway-service/bootstrap"
	"github.com/gin-gonic/gin"
)

func Setup(env *bootstrap.Env, timeout time.Duration, gin *gin.Engine) {

	// Auth Service
	// auth.RegisterRoutes(gin, env)

}
