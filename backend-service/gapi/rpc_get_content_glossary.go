package gapi

import (
	"context"

	"github.com/FusionLabInc/nanolearn/backend-service/repository"
	"github.com/FusionLabInc/nanolearn/backend-service/utils/api_response"

	"github.com/FusionLabInc/nanolearn/backend-service/pb"
)

func (s *Server) GetContentGlossary(ctx context.Context, req *pb.GetContentGlossaryRequest) (*pb.GetContentGlossaryResponse, error) {

	ur := repository.NewContentRepository(s.Db)

	contentId := req.GetContentId()

	contentGlossary := ur.GetContentGlossary(ctx, contentId)
	if contentGlossary == nil {
		return api_response.ErrorBadRequest(&pb.GetContentGlossaryResponse{}, "Unable to fetch glossary details").(*pb.GetContentGlossaryResponse), nil

	}

	glossaryMap := make(map[string]interface{})

	glossaryMap["glossary"] = contentGlossary

	return api_response.Success(&pb.GetContentGlossaryResponse{}, "Glossary successfully fethed", glossaryMap).(*pb.GetContentGlossaryResponse), nil

}
