package main

import (
	"time"

	"github.com/FusionLabInc/nanolearn/gateway-service/api/route"
	"github.com/FusionLabInc/nanolearn/gateway-service/bootstrap"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

const (
	contextTimeout = 10
)

func main() {

	app := bootstrap.App()

	env := app.Env

	timeout := time.Duration(contextTimeout) * time.Second

	g := gin.Default()

	// gin.SetMode(gin.ReleaseMode)

	g.Use(cors.New(cors.Config{
		AllowOrigins: []string{"*"},
		AllowMethods: []string{"PUT", "PATCH", "GET", "POST", "OPTIONS"},
		AllowHeaders: []string{"Origin, X-Requested-With, Content-Type, Accept", "token"},
	}))

	route.Setup(env, timeout, g)

	g.Run(env.AppServerUrl)

}
