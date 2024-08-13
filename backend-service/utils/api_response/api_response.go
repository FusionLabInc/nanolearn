package api_response

import (
	"fmt"

	"github.com/FusionLabInc/nanolearn/backend-service/domain"
	"github.com/FusionLabInc/nanolearn/backend-service/pb"
	"google.golang.org/grpc/codes"
)

type ApiResponse interface {
	Success(message string, args map[string]interface{}) interface{}
	ErrorInternal(message string) interface{}
	ErrorBadRequest(message string) interface{}
	ErrorNotFound(message string) interface{}
	ErrorAlreadyExists(message string) interface{}
}

func Success(response interface{}, message string, args map[string]interface{}) interface{} {

	switch r := response.(type) {

	case *pb.FetchSetupNicknamePoolResponse:

		rr := r
		rr.Code = int64(codes.OK)
		rr.Message = message
		rr.NicknamesPool = args["nicknamesPool"].([]string)
		return rr

	case *pb.LoginResponse:

		rr := r
		rr.Code = int64(codes.OK)
		rr.Message = message
		rr.AccessToken = args["access_token"].(string)
		rr.AccessTokenExpiresAt = args["access_token_expires_at"].(int64)
		rr.RefreshToken = args["refresh_token"].(string)
		rr.RefreshTokenExpiresAt = args["refresh_token_expires_at"].(int64)
		rr.UserId = args["user_id"].(string)
		return rr

	case *pb.ValidateTokenResponse:

		rr := r
		rr.Code = int64(codes.OK)
		rr.Message = message
		rr.UserId = args["user_id"].(string)
		return rr

	case *pb.GetUserDetailsResponse:

		rr := r
		rr.Code = int64(codes.OK)
		rr.Message = message
		rr.UserId = args["user_id"].(string)
		rr.CreatedAt = args["created_at"].(int64)
		rr.Username = args["username"].(string)

		var pbContents []*pb.Content
		for _, content := range args["contents"].([]domain.Content) {
			pbContent := &pb.Content{
				Id:       content.ID,
				FileName: content.FileName,
				Size:     content.Size,
			}
			pbContents = append(pbContents, pbContent)
		}
		rr.Contents = pbContents
		return rr

	case *pb.GetContentSummariesResponse:

		rr := r
		rr.Code = int64(codes.OK)
		rr.Message = message

		var summaries []*pb.Section
		for _, summary := range args["summaries"].([]*domain.Section) {

			detailedExplanations := make(map[string]*pb.DetailedExplanation)
			for k, v := range summary.DetailedExplanations {
				detailedExplanations[k] = &pb.DetailedExplanation{
					Content: v,
				}
			}

			examples := make([]*pb.Example, len(summary.Examples))
			for i, example := range summary.Examples {
				examples[i] = &pb.Example{
					Scenario:    example.Scenario,
					Description: example.Description,
					Relation:    example.Relation,
				}
			}

			quizzes := make([]*pb.Quiz, len(summary.Quizzes))
			for i, quiz := range summary.Quizzes {
				quizzes[i] = &pb.Quiz{
					Question:      quiz.Question,
					Type:          quiz.Type,
					Options:       quiz.Options,
					CorrectAnswer: quiz.CorrectAnswer,
				}
			}

			summary := &pb.Section{
				SectionTitle:         summary.SectionTitle,
				Summary:              summary.Summary,
				DetailedExplanations: detailedExplanations,
				Examples:             examples,
				Quizzes:              quizzes,
			}

			summaries = append(summaries, summary)
		}
		fmt.Println(summaries)
		rr.Summaries = summaries
		return rr

	case *pb.GetContentGlossaryResponse:

		rr := r
		rr.Code = int64(codes.OK)
		rr.Message = message
		rr.Glossary = args["glossary"].(*pb.Glossary)
		return rr

	default:

		return nil

	}
}

func ErrorInternal(response interface{}, message string) interface{} {

	switch r := response.(type) {

	case *pb.FetchSetupNicknamePoolResponse:

		rr := r
		rr.Code = int64(codes.Internal)
		rr.Message = message
		return rr

	case *pb.LoginResponse:

		rr := r
		rr.Code = int64(codes.Internal)
		rr.Message = message
		return rr

	case *pb.ValidateTokenResponse:

		rr := r
		rr.Code = int64(codes.Internal)
		rr.Message = message
		return rr

	case *pb.GetUserDetailsResponse:

		rr := r
		rr.Code = int64(codes.Internal)
		rr.Message = message
		return rr

	default:

		return nil

	}
}

func ErrorBadRequest(response interface{}, message string) interface{} {

	switch r := response.(type) {

	case *pb.FetchSetupNicknamePoolResponse:

		rr := r
		rr.Code = int64(codes.InvalidArgument)
		rr.Message = message
		return rr

	case *pb.LoginResponse:

		rr := r
		rr.Code = int64(codes.InvalidArgument)
		rr.Message = message
		return rr

	case *pb.ValidateTokenResponse:

		rr := r
		rr.Code = int64(codes.InvalidArgument)
		rr.Message = message
		return rr

	case *pb.GetUserDetailsResponse:

		rr := r
		rr.Code = int64(codes.InvalidArgument)
		rr.Message = message
		return rr

	case *pb.GetContentSummariesResponse:

		rr := r
		rr.Code = int64(codes.InvalidArgument)
		rr.Message = message
		return rr

	case *pb.GetContentGlossaryResponse:

		rr := r
		rr.Code = int64(codes.InvalidArgument)
		rr.Message = message
		return rr

	default:

		return nil

	}
}

func ErrorNotFound(response interface{}, message string) interface{} {

	switch r := response.(type) {

	case *pb.FetchSetupNicknamePoolResponse:

		rr := r
		rr.Code = int64(codes.NotFound)
		rr.Message = message
		return rr

	case *pb.LoginResponse:

		rr := r
		rr.Code = int64(codes.NotFound)
		rr.Message = message
		return rr

	case *pb.ValidateTokenResponse:

		rr := r
		rr.Code = int64(codes.NotFound)
		rr.Message = message
		return rr

	case *pb.GetUserDetailsResponse:

		rr := r
		rr.Code = int64(codes.NotFound)
		rr.Message = message
		return rr

	default:

		return nil

	}
}

func ErrorAlreadyExists(response interface{}, message string) interface{} {

	switch r := response.(type) {

	case *pb.FetchSetupNicknamePoolResponse:

		rr := r
		rr.Code = int64(codes.AlreadyExists)
		rr.Message = message
		return rr

	case *pb.LoginResponse:

		rr := r
		rr.Code = int64(codes.AlreadyExists)
		rr.Message = message
		return rr

	case *pb.ValidateTokenResponse:

		rr := r
		rr.Code = int64(codes.AlreadyExists)
		rr.Message = message
		return rr

	case *pb.GetUserDetailsResponse:

		rr := r
		rr.Code = int64(codes.AlreadyExists)
		rr.Message = message
		return rr

	default:

		return nil

	}
}

func ErrorUnauthorized(response interface{}, message string) interface{} {

	switch r := response.(type) {

	case *pb.FetchSetupNicknamePoolResponse:

		rr := r
		rr.Code = int64(codes.PermissionDenied)
		rr.Message = message
		return rr

	case *pb.LoginResponse:

		rr := r
		rr.Code = int64(codes.PermissionDenied)
		rr.Message = message
		return rr

	case *pb.ValidateTokenResponse:

		rr := r
		rr.Code = int64(codes.PermissionDenied)
		rr.Message = message
		return rr

	case *pb.GetUserDetailsResponse:

		rr := r
		rr.Code = int64(codes.PermissionDenied)
		rr.Message = message
		return rr

	default:

		return nil

	}
}
