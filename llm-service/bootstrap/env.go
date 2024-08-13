package bootstrap

import (
	"log"

	"github.com/spf13/viper"
)

type Env struct {
	AppEnv             string `mapstructure:"ENVIRONMENT"`
	AppServerPort      string `mapstructure:"SERVER_PORT"`
	AppServerUrl       string `mapstructure:"SERVER_URL"`
	TokenSymmetricKey  string `mapstructure:"TOKEN_SYMMETRIC_KEY"`
	GeminiApiKey       string `mapstructure:"GEMINI_API_KEY"`
	UnidocApiKey       string `mapstructure:"UNIDOC_API_KEY"`
	GoogleConfigBase64 string `mapstructure:"GOOGLE_CONFIG_BASE64"`
}

func NewEnv() *Env {
	env := Env{}
	viper.SetConfigFile(".env")

	err := viper.ReadInConfig()
	if err != nil {
		log.Fatal("Can't find the file .env : ", err)
	}

	err = viper.Unmarshal(&env)
	if err != nil {
		log.Fatal("Environment can't be loaded: ", err)
	}

	if env.AppEnv == "DEVELOPMENT" {
		log.Println("The App is running in development env")
	}

	return &env
}
