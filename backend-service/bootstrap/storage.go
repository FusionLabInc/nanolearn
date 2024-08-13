package bootstrap

import (
	"context"

	"cloud.google.com/go/storage"
	"github.com/FusionLabInc/nanolearn/backend-service/utils/methods"
	"google.golang.org/api/option"
)

type Storage struct {
	Client *storage.Client
}

func NewStorage(env *Env) *Storage {

	cred, err := methods.DecodeBase64ToBytes(env.GoogleConfigBase64)
	if err != nil {
		return nil
	}

	opt := option.WithCredentialsJSON(cred)
	ctx := context.Background()

	app, err := storage.NewClient(ctx, opt)
	if err != nil {
		return nil
	}

	return &Storage{
		Client: app,
	}
}
