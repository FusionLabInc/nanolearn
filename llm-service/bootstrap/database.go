package bootstrap

import (
	"context"

	"cloud.google.com/go/firestore"
	firebase "firebase.google.com/go"
	"github.com/FusionLabInc/nanolearn/llm-service/utils/methods"
	"google.golang.org/api/option"
)

type Database struct {
	Client *firestore.Client
}

func NewDatabase(env *Env) *Database {

	cred, err := methods.DecodeBase64ToBytes(env.GoogleConfigBase64)
	if err != nil {
		return nil
	}

	opt := option.WithCredentialsJSON(cred)
	ctx := context.Background()

	app, err := firebase.NewApp(ctx, nil, opt)
	if err != nil {
		return nil
	}

	client, err := app.Firestore(ctx)

	return &Database{
		Client: client,
	}
}
