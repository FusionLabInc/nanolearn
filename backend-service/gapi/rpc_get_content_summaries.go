package gapi

import (
	"context"

	"github.com/FusionLabInc/nanolearn/backend-service/repository"
	"github.com/FusionLabInc/nanolearn/backend-service/utils/api_response"

	"github.com/FusionLabInc/nanolearn/backend-service/pb"
)

func (s *Server) GetContentSummaries(ctx context.Context, req *pb.GetContentSummariesRequest) (*pb.GetContentSummariesResponse, error) {

	ur := repository.NewContentRepository(s.Db)

	contentId := req.GetContentId()

	contentSummaries := ur.GetContentSummaries(ctx, contentId)

	if contentSummaries == nil {
		return api_response.ErrorBadRequest(&pb.GetContentSummariesResponse{}, "Unable to fetch summaries details").(*pb.GetContentSummariesResponse), nil

	}

	summaryMap := make(map[string]interface{})

	summaryMap["summaries"] = contentSummaries

	return api_response.Success(&pb.GetContentSummariesResponse{}, "Summaries successfully fethed", summaryMap).(*pb.GetContentSummariesResponse), nil

}
