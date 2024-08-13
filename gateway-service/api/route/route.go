package route

import (
	"time"

	"github.com/FusionLabInc/nanolearn/gateway-service/bootstrap"
	backend "github.com/FusionLabInc/nanolearn/gateway-service/pkg/backend"
	llm "github.com/FusionLabInc/nanolearn/gateway-service/pkg/llm"
	"github.com/gin-gonic/gin"
)

func Setup(env *bootstrap.Env, timeout time.Duration, gin *gin.Engine) {

	// Backend Service
	a := backend.RegisterRoutes(gin, env)

	// LLM Service
	llm.RegisterRoutes(gin, env, a)

}
