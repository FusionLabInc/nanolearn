package repository

import (
	"context"
	"errors"
	"fmt"
	"io"
	"strings"

	"github.com/FusionLabInc/nanolearn/llm-service/bootstrap"
	"github.com/google/generative-ai-go/genai"
)

const (
	generateNicknameSystemInstruction = `You are a skilled and creative username curator. 
										 Given a list of keywords, generate a unique, engaging, and age-appropriate username for a microlearning lesson. Prioritize relevance, brevity, and memorability.
										 Consider the target audience of young learners when crafting your suggestions. Use a mix of letters, numbers, and optional special characters.
										 Return only the generated username in your response and don't return any words in the list of keywords.


`

	generateNicknamePrompt = `Generate a creative, unique username combining the following keywords: %s. The username should be engaging, suitable for a young audience, and include a mix of letters, numbers, and optional special characters. Avoid overly complex or repetitive usernames.`
)

type SetupRepository interface {
	GenerateNickname(c context.Context, selectedNicknamesFromPool []string, env bootstrap.Env) *string
}

type setupRepository struct {
	model *genai.GenerativeModel
}

func NewSetupRepository(llm *bootstrap.Llm) SetupRepository {

	client := llm.Client

	modelFlash := client.GenerativeModel("gemini-1.5-flash-001")

	modelFlash.SafetySettings = []*genai.SafetySetting{
		{
			Category:  genai.HarmCategoryHarassment,
			Threshold: genai.HarmBlockMediumAndAbove,
		},
		{
			Category:  genai.HarmCategoryHateSpeech,
			Threshold: genai.HarmBlockMediumAndAbove,
		},
		{
			Category:  genai.HarmCategorySexuallyExplicit,
			Threshold: genai.HarmBlockMediumAndAbove,
		},
		{
			Category:  genai.HarmCategoryDangerousContent,
			Threshold: genai.HarmBlockMediumAndAbove,
		},
	}

	modelFlash.SetTemperature(1.0)

	modelFlash.SetMaxOutputTokens(8192)

	return &setupRepository{
		model: modelFlash,
	}
}

func (sr *setupRepository) GenerateNickname(c context.Context, selectedNicknamesFromPool []string, env bootstrap.Env) *string {

	sr.model.SetTemperature(1.0)

	sr.model.SetMaxOutputTokens(30)

	sr.model.SystemInstruction = &genai.Content{
		Parts: []genai.Part{genai.Text(generateNicknameSystemInstruction)},
	}

	prompt := fmt.Sprintf(generateNicknamePrompt, strings.Join(selectedNicknamesFromPool, ", "))

	fmt.Println(prompt)

	stream := sr.model.GenerateContentStream(c, genai.Text(prompt))

	for {
		response, err := stream.Next()
		if errors.Is(err, io.EOF) {
			fmt.Println(err)
			break
		}
		if err != nil {
			fmt.Println(err)
			return nil
		}

		if len(response.Candidates) == 0 {
			continue
		}

		for _, cand := range response.Candidates {
			if cand.Content != nil {
				for _, part := range cand.Content.Parts {
					fmt.Println(part)
					text := strings.ToLower(fmt.Sprintf("@%s", part))
					return &text
				}
			}
		}

	}

	return nil
}
