package repository

import (
	"context"
	"encoding/json"
	"fmt"

	"cloud.google.com/go/firestore"
	"github.com/FusionLabInc/nanolearn/llm-service/bootstrap"
	"github.com/google/generative-ai-go/genai"
)

const (
	generateContentSummarySystemInstruction = `
									You are a seasoned educator with a mastery of breaking down complex information into easily digestible and engaging learning modules.

									Your expertise lies in transforming dense text into interactive learning experiences, complete with summaries quizzes, problem sets and charts.

									Imagine you are crafting an engaging lesson plan for a curious and eager student.

									Adopt a first-person narrative style as if you were the original author of the content.

									Analyze the full text and then divide the text into distinct sections that explain the concepts in a successive manner and provide concise summaries for each section.

									Return the results in a JSON format with a 'main_sections' array containing objects with 'section_title' and 'summary' properties.

									The 'summary' property should be a dictionary where keys are integers starting from 0 and values are the corresponding sentences in the summary.

									Give a least two sentences summary for each section and make each summary sentence as concise as possible.

									Also generate charts based on the available charts in the Sample Response for each sections that you believe with a high accuracy that requires charts to give a more detailed explanation of the concepts highlighted in the summary.

									Use this guide to determine which chart is appropriate for each section:

									1. Bar Chart

										Purpose: Compares categorical data using rectangular bars.

										Best for: Showing differences between categories, ranking data, and identifying outliers.

										Example: Comparing sales of different products.

									2. Line Chart

										Purpose: Displays trends over time or continuous data.

										Best for: Showing changes over time, identifying patterns, and forecasting trends.

										Example: Tracking website traffic over a year.

									3.Pie Chart

										Purpose: Shows the proportion of different categories to a whole.

										Best for: Comparing parts to a whole, visualizing market share, or displaying composition.

										Example: Breaking down customer demographics by age group.

									4.Scatter Plot

										Purpose: Displays the relationship between two numerical variables.

										Best for: Identifying correlations, clusters, and outliers.

										Example: Showing the relationship between advertising spending and sales.

									5. Histogram

										Purpose: Visualizes the distribution of numerical data.

										Best for: Understanding data distribution, identifying patterns, and outliers.

										Example: Analyzing the distribution of customer order values.

									Generate at least a chart for each section unless you are sure with a high accuracy that the section does not require a chart.

									Return the results in a JSON format based on this Sample Response: %s

									Refer to the Original Text to ensure accuracy and depth.

									`

	generateDeepContentExplanationSystemInstruction = `
									You are a seasoned educator with a mastery of breaking down complex information into easily digestible and engaging learning modules.

									Your expertise lies in transforming dense text into interactive learning experiences, complete with summaries quizzes, problem sets and charts.

									You have previously analyzed this Original Text: {%s} and divided it into distinct sections that explain the concepts in a successive manner and provided concise summaries for each section in this Language: {%s}.
									
									Now provide a very detailed explanation of the sections based on the Summary following these steps.

									1. Provide detailed explanation of the sections that spans over 400 to 1000 words depending on which length ensures the concepts is well explained.

										The should detailed_explanations be a dictionary where keys are integers starting from 0 and values are the corresponding sentences in the detailed explanation.

										This should still make the explanations as detailed as possible.

									2. Provide at least 3 examples based on real-world scenarios and events that draw parallelisms to the concepts highlighted in the summary. This should relate to real-world scenarios as much as possible and help the student understand the concepts better.

									3. Short pop up quizzes. Provide at least 2 quizzes based on the concepts highlighted in the summary and highlight the correct answers.

									Adopt a first-person narrative style as if you were the original author of the content.

									Refer to the Original Text to ensure accuracy and depth.

									Return the results in a JSON format based on this Sample Response: %s
									`

	generateGlossarySystemInstruction = `

									You are a seasoned educator with a mastery of breaking down complex information into easily digestible and engaging learning modules.

									Your expertise lies in transforming dense text into interactive learning experiences, complete with summaries quizzes, problem sets and charts.

									Imagine you are crafting an engaging lesson plan for a curious and eager student.

									Adopt a first-person narrative style as if you were the original author of the content.

									Generate an exhaustive glossary of terms explained in the Original Text.

									Please use only facts provided in the Original Text and do not make up facts. Remember that you are a seasoned educator and you are not allowed to make up facts.

									Refer to the Original Text to ensure accuracy and depth.

									Return the results in a JSON format based on this Sample Response: %s
								`

	generateContentSummaryPrompt = `Generate based on this Original Text: {%s} and Language: {%s}`

	generateDeepContentExplanationPrompt = `Generate based on this previous Summary: {%s} {%s}.`

	generateGlossaryPrompt = `Generate based on this Original Text: {%s} and Language: {%s}`

	contentModelName  = "content"
	glossaryModelName = "glossary"
)

type ContentRepository interface {
	GenerateContentSummary(c context.Context, content string, env bootstrap.Env) *MainContent
	GenerateDeepContentExplanation(c context.Context, content string, sectionTitle string, sectionSummary map[string]string, env bootstrap.Env) *Section
	GenerateContentGlossary(c context.Context, content string, env bootstrap.Env) *GlossaryContent
	AddContentSummary(c context.Context, contentId string, userId string, sectionId string, sectionIndex int, data *Section) bool
	AddContentGlossary(c context.Context, contentId string, data *GlossaryContent) bool
}

type contentRepository struct {
	model  *genai.GenerativeModel
	Client *firestore.Client
}

func NewContentRepository(llm *bootstrap.Llm, db *bootstrap.Database) ContentRepository {

	client := llm.Client

	modelFlash := client.GenerativeModel("gemini-1.5-pro-001")

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

	return &contentRepository{
		model:  modelFlash,
		Client: db.Client,
	}
}

func (cr *contentRepository) GenerateContentSummary(c context.Context, content string, env bootstrap.Env) *MainContent {

	var sampleResponseString = `{
		"main_sections": [
			{
			"section_title": "Section Title",
			"summary": {
				"0": "",
				"1": "",
				"2": "",
	  
			},
			"charts": [
				  {
					  "section_title": "section title that the chart is based on",
					  "type": "bar",
					  "description": "",
					  "data": [
						  {"variable": "", "value": 0},
						  {"variable": "", "value": 0},
					  ],
				  },
				  {
					  "section_title": "section title that the chart is based on",
					  "type": "line",
					  "description": "",
					   "data": [{"x": 0, "y": 0}, {"x": 0, "y": 0}],
				  },
				  {
					  "section_title": "section title that the chart is based on",
					  "type": "pie",
					  "description": "",
					  "data": [
						  {"label": "", "value": 0 },
						  {"label": "", "value": 0},
						  {"label": "", "value": 0},
					  ],
				  },
				  {
					  "section_title": "section title that the chart is based on",
					  "type": "scatter",
					  "description": "",
					  "data": [{"x": 0, "y": 0}, {"x": 0, "y": 0}],
				  },
				  {
					  "section_title": "section title that the chart is based on",
					  "type": "histogram",
					  "description": "",
					  "data": [
						  {"bin": "", "count": 0},
						  {"bin": "", "count": 0},
					  ],
				  },
			  ],
		  },
		  ...
		]
	  }`

	generateContentSummarySystemInstruction := fmt.Sprintf(generateContentSummarySystemInstruction, sampleResponseString)

	cr.model.SystemInstruction = &genai.Content{
		Parts: []genai.Part{genai.Text(generateContentSummarySystemInstruction)},
	}

	cr.model.GenerationConfig = genai.GenerationConfig{
		ResponseMIMEType: "application/json",
	}

	prompt := fmt.Sprintf(generateContentSummaryPrompt, content, "en")

	resp, _ := cr.model.GenerateContent(c, genai.Text(prompt))

	if textPart, ok := resp.Candidates[0].Content.Parts[0].(genai.Text); ok {

		var resContent MainContent

		err := json.Unmarshal([]byte(textPart), &resContent)
		if err != nil {
			fmt.Println("Error unmarshaling JSON:", err)
			return nil
		}

		return &resContent
	}

	return nil
}

func (cr *contentRepository) GenerateDeepContentExplanation(c context.Context, content string, sectionTitle string, sectionSummary map[string]string, env bootstrap.Env) *Section {

	var sampleResponseString = `{
			"section_title": "Introduction",
			"summary": "The Crypto Solutions Suite aims to provide a comprehensive platform for managing cryptocurrency transactions and financial services on a global scale. It will utilize blockchain technology to facilitate international transactions, enhance cross-border trade, and offer a secure banking experience.",
			"explanation": {
				"detailed_explanations": {
					"0": "In a world that's becoming increasingly interconnected, the demand for a sophisticated cryptocurrency solution that transcends geographical boundaries is paramount. That's where the Crypto Solutions Suite comes in.",
					"1": "This platform is designed to address this need by offering a comprehensive set of robust financial products and services that seamlessly facilitate international cryptocurrency transactions.",
					"2": "The suite aims to streamline cross-border trade, providing businesses and individuals with a secure and efficient banking experience on a global scale. ",
					"3": "The power behind the Crypto Solutions Suite lies in its utilization of advanced blockchain technologies. ",
					"4": "This allows us to deliver innovative solutions, ensuring our clients can easily manage their digital assets across a multitude of currencies and regulatory environments."
				},
				"examples": [
					{
						"scenario": "A freelance graphic designer based in the Philippines completing a project for a US-based client.",
						"description": "Traditionally, receiving payment might involve high international transfer fees and delays. However, with the Crypto Solutions Suite, the client can pay the designer instantly in cryptocurrency, bypassing these hurdles.",
						"relation": "This illustrates how the platform facilitates international transactions and enhances cross-border trade."
					},
					{
						"scenario": "A European importer purchasing goods from an Asian supplier.",
						"description": "The importer can utilize the Crypto Solutions Suite to make payments securely and transparently using cryptocurrency. The blockchain-based system ensures trust and accountability throughout the transaction.",
						"relation": "This showcases the platform's ability to provide a secure banking experience for international trade."
					},
					{
						"scenario": "A non-profit organization seeking donations for disaster relief efforts.",
						"description": "Using the Crypto Solutions Suite, they can accept donations in various cryptocurrencies from a global audience. The platform's transparency ensures that donors can track their contributions, fostering trust and encouraging wider participation.",
						"relation": "This highlights how the platform enables new possibilities in global finance, even for charitable causes."
					}
				],
				"quiz": [
					{
						"question": "What is the primary objective of the Crypto Solutions Suite?",
						"type": "multiple_choice",
						"options": {
							"A": "To provide a secure and efficient platform for global cryptocurrency transactions.",
							"B": "To replace traditional banking systems entirely.",
							"C": "To focus solely on facilitating cross-border trade for large corporations.",
							"D": "To create a closed ecosystem for a single cryptocurrency."
						},
						"correct_answer": "A"
					},
					{
						"question": "Does the Crypto Solutions Suite leverage blockchain technology?",
						"type": "true_or_false",
						"options": {
							"A": "True",
							"B": "False"
						},
						"correct_answer": "A"
					}
				]
			}
		}
	`

	generateDeepContentExplanationSystemInstruction := fmt.Sprintf(generateDeepContentExplanationSystemInstruction, content, "en", sampleResponseString)

	cr.model.SystemInstruction = &genai.Content{
		Parts: []genai.Part{genai.Text(generateDeepContentExplanationSystemInstruction)},
	}

	cr.model.GenerationConfig = genai.GenerationConfig{
		ResponseMIMEType: "application/json",
	}

	prompt := fmt.Sprintf(generateDeepContentExplanationPrompt, sectionTitle, sectionSummary)

	resp, _ := cr.model.GenerateContent(c, genai.Text(prompt))

	if textPart, ok := resp.Candidates[0].Content.Parts[0].(genai.Text); ok {

		var resContent Section

		fmt.Println(textPart)

		err := json.Unmarshal([]byte(textPart), &resContent)
		if err != nil {
			fmt.Println("Error unmarshaling JSON:", err)
			return nil
		}

		return &resContent
	}

	return nil
}

func (cr *contentRepository) GenerateContentGlossary(c context.Context, content string, env bootstrap.Env) *GlossaryContent {

	var sampleResponseString = `{
		"glossary": {
			"A": [
			{
				"term": "API (Application Programming Interface)",
				"definition": "A set of rules and definitions that allows one software application to interact with another."
			},
			{
				"term": "Agile",
				"definition": "A methodology for project management and software development that promotes continuous iteration and collaboration."
			}
			],
			"B": [
			{
				"term": "Backend",
				"definition": "The part of a software application that handles the server-side logic, database interactions, and server configuration."
			},
			{
				"term": "Blockchain",
				"definition": "A decentralized digital ledger that records transactions across many computers securely and transparently."
			}
			],
			"C": [
			{
				"term": "Cloud Computing",
				"definition": "The delivery of computing services over the internet, including storage, processing power, and applications."
			},
			{
				"term": "Continuous Integration (CI)",
				"definition": "A software development practice where developers regularly merge their code changes into a central repository, followed by automated builds and tests."
			}
			]
		}
	}
	`

	generateGlossarySystemInstruction := fmt.Sprintf(generateGlossarySystemInstruction, sampleResponseString)

	cr.model.SystemInstruction = &genai.Content{
		Parts: []genai.Part{genai.Text(generateGlossarySystemInstruction)},
	}

	cr.model.GenerationConfig = genai.GenerationConfig{
		ResponseMIMEType: "application/json",
	}

	prompt := fmt.Sprintf(generateGlossaryPrompt, content, "en")

	resp, _ := cr.model.GenerateContent(c, genai.Text(prompt))

	if textPart, ok := resp.Candidates[0].Content.Parts[0].(genai.Text); ok {
		var resContent GlossaryContent

		fmt.Println(textPart)

		err := json.Unmarshal([]byte(textPart), &resContent)
		if err != nil {
			fmt.Println("Error unmarshaling JSON:", err)
			return nil
		}

		return &resContent
	}

	return nil

}

func (cr *contentRepository) AddContentSummary(c context.Context, contentId string, userId string, sectionId string, sectionIndex int, data *Section) bool {

	sectionMap := make(map[string]interface{})

	sectionMap["detailed_explanations"] = data.DetailedExplanations

	sectionMap["examples"] = data.Examples

	sectionMap["quizzes"] = data.Quizzes

	sectionMap["section_title"] = data.SectionTitle

	sectionMap["section_summary"] = data.Summary

	sectionMap["content_id"] = contentId

	sectionMap["user_id"] = userId

	sectionMap["section_index"] = sectionIndex

	sectionMap["id"] = sectionId

	_, newErr := cr.Client.Collection(contentModelName).Doc(sectionId).Set(c, sectionMap)

	if newErr != nil {
		fmt.Printf("error adding content: %v", newErr)
		return false
	}

	return true
}

func (cr *contentRepository) AddContentGlossary(c context.Context, contentId string, data *GlossaryContent) bool {

	_, newErr := cr.Client.Collection(glossaryModelName).Doc(contentId).Set(c, data.Glossary)

	if newErr != nil {
		fmt.Printf("error adding glossary: %v", newErr)
		return false
	}

	return true
}
