package bootstrap

import (
	"log"
	"time"

	"github.com/spf13/viper"
)

type Env struct {
	AppEnv               string        `mapstructure:"ENVIRONMENT"`
	AppServerPort        string        `mapstructure:"SERVER_PORT"`
	AppServerUrl         string        `mapstructure:"SERVER_URL"`
	GoogleConfigBase64   string        `mapstructure:"GOOGLE_CONFIG_BASE64"`
	StorageBucketUrl     string        `mapstructure:"STORAGE_BUCKET_URL"`
	TokenSymmetricKey    string        `mapstructure:"TOKEN_SYMMETRIC_KEY"`
	AccessTokenDuration  time.Duration `mapstructure:"ACCESS_TOKEN_DURATION"`
	RefreshTokenDuration time.Duration `mapstructure:"REFRESH_TOKEN_DURATION"`
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
