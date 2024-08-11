package bootstrap

import (
	"context"
	"fmt"

	"github.com/google/generative-ai-go/genai"
	"google.golang.org/api/option"
)

type Llm struct {
	Client *genai.Client
}

func NewLLm(env *Env) *Llm {

	ctx := context.Background()

	flashClient, err := genai.NewClient(ctx, option.WithAPIKey(env.GeminiApiKey))
	if err != nil {
		fmt.Println("Error creating client:", err)
		return nil
	}

	// defer flashClient.Close()

	return &Llm{
		Client: flashClient,
	}
}
