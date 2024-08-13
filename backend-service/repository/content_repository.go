package repository

import (
	"context"
	"fmt"

	"cloud.google.com/go/firestore"
	"github.com/FusionLabInc/nanolearn/backend-service/bootstrap"
	"github.com/FusionLabInc/nanolearn/backend-service/domain"
)

const (
	contentModelName  = "content"
	glossaryModelName = "glossary"
)

type ContentRepository interface {
	AddContentSummary(c context.Context, contentId string, userId string, sectionId string, sectionIndex int, data *domain.Section) bool
	AddContentGlossary(c context.Context, contentId string, data *domain.GlossaryContent) bool
	GetContentSummaries(c context.Context, contentId string) []*domain.Section
	GetContentGlossary(c context.Context, contentId string) *domain.Glossary
}

type contentRepository struct {
	Client *firestore.Client
}

func NewContentRepository(db *bootstrap.Database) ContentRepository {

	return &contentRepository{
		Client: db.Client,
	}
}

func (cr *contentRepository) AddContentSummary(c context.Context, contentId string, userId string, sectionId string, sectionIndex int, data *domain.Section) bool {

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

func (cr *contentRepository) AddContentGlossary(c context.Context, contentId string, data *domain.GlossaryContent) bool {

	_, newErr := cr.Client.Collection(glossaryModelName).Doc(contentId).Set(c, data.Glossary)

	if newErr != nil {
		fmt.Printf("error adding glossary: %v", newErr)
		return false
	}

	return true
}

func (cr *contentRepository) GetContentSummaries(c context.Context, contentId string) []*domain.Section {

	var sectionsData = []*domain.Section{}

	query := cr.Client.Collection(contentModelName).Where("content_id", "==", contentId)

	docs, err := query.Documents(c).GetAll()

	if err != nil {
		fmt.Printf("error initializing database: %v", err)
		return nil
	}

	for _, doc := range docs {
		var section domain.Section
		if err := doc.DataTo(&section); err != nil {
			return nil
		}
		sectionsData = append(sectionsData, &section)
	}

	return sectionsData
}

func (cr *contentRepository) GetContentGlossary(c context.Context, contentId string) *domain.Glossary {

	data, err := cr.Client.Collection(glossaryModelName).Doc(contentId).Get(c)

	if err != nil {
		fmt.Printf("error fetching glossary: %v", err)
		return nil
	}

	var glossary *domain.Glossary

	if err := data.DataTo(&glossary); err != nil {
		return nil
	}

	return glossary

}
