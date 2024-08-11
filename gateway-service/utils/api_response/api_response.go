package api_response

import (
	"net/http"

	"github.com/FusionLabInc/nanolearn/gateway-service/pkg/backend/pb"
	llm "github.com/FusionLabInc/nanolearn/gateway-service/pkg/llm/pb"

	"github.com/gin-gonic/gin"
	"google.golang.org/grpc/codes"
)

func Respond(ctx *gin.Context, response interface{}) interface{} {

	switch r := response.(type) {

	case *pb.FetchSetupNicknamePoolResponse:

		rr := r

		switch rr.Code {

		case int64(codes.OK):

			ctx.JSON(http.StatusOK, gin.H{
				"status":  "success",
				"message": rr.Message,
				"data": gin.H{
					"nicknames_pool": r.NicknamesPool,
				},
			})

		case int64(codes.Internal):

			ctx.JSON(http.StatusInternalServerError, BaseErrorResponse(rr.Message))

		case int64(codes.InvalidArgument):

			ctx.JSON(http.StatusBadRequest, BaseErrorResponse(rr.Message))

		case int64(codes.NotFound):

			ctx.JSON(http.StatusNotFound, BaseErrorResponse(rr.Message))

		case int64(codes.AlreadyExists):

			ctx.JSON(http.StatusNotFound, BaseErrorResponse(rr.Message))

		default:

			return nil

		}

	case *pb.LoginResponse:

		rr := r

		switch rr.Code {

		case int64(codes.OK):

			ctx.JSON(http.StatusOK, gin.H{
				"status":  "success",
				"message": rr.Message,
				"data": gin.H{
					"access_token":             rr.AccessToken,
					"access_token_expires_at":  rr.AccessTokenExpiresAt,
					"refresh_token":            rr.RefreshToken,
					"refresh_token_expires_at": rr.RefreshTokenExpiresAt,
					"user_id":                  rr.UserId,
				},
			})

		case int64(codes.Internal):

			ctx.JSON(http.StatusInternalServerError, BaseErrorResponse(rr.Message))

		case int64(codes.InvalidArgument):

			ctx.JSON(http.StatusBadRequest, BaseErrorResponse(rr.Message))

		case int64(codes.NotFound):

			ctx.JSON(http.StatusNotFound, BaseErrorResponse(rr.Message))

		case int64(codes.AlreadyExists):

			ctx.JSON(http.StatusNotFound, BaseErrorResponse(rr.Message))

		default:

			return nil

		}

	case *pb.ValidateTokenResponse:

		rr := r

		switch rr.Code {

		case int64(codes.OK):

			ctx.JSON(http.StatusOK, gin.H{
				"status":  "success",
				"message": rr.Message,
				"data": gin.H{
					"user_id": rr.UserId,
				},
			})

		case int64(codes.Internal):

			ctx.JSON(http.StatusInternalServerError, BaseErrorResponse(rr.Message))

		case int64(codes.InvalidArgument):

			ctx.JSON(http.StatusBadRequest, BaseErrorResponse(rr.Message))

		case int64(codes.NotFound):

			ctx.JSON(http.StatusNotFound, BaseErrorResponse(rr.Message))

		case int64(codes.AlreadyExists):

			ctx.JSON(http.StatusNotFound, BaseErrorResponse(rr.Message))

		default:

			return nil

		}

	case *pb.GetUserDetailsResponse:

		rr := r

		switch rr.Code {

		case int64(codes.OK):

			ctx.JSON(http.StatusOK, gin.H{
				"status":  "success",
				"message": rr.Message,
				"data": gin.H{
					"user": gin.H{
						"user_id":    rr.UserId,
						"created_at": rr.CreatedAt,
						"username":   rr.Username,
					},
				},
			})

		case int64(codes.Internal):

			ctx.JSON(http.StatusInternalServerError, BaseErrorResponse(rr.Message))

		case int64(codes.InvalidArgument):

			ctx.JSON(http.StatusBadRequest, BaseErrorResponse(rr.Message))

		case int64(codes.NotFound):

			ctx.JSON(http.StatusNotFound, BaseErrorResponse(rr.Message))

		case int64(codes.AlreadyExists):

			ctx.JSON(http.StatusNotFound, BaseErrorResponse(rr.Message))

		default:

			return nil

		}

	case *llm.GenerateNicknameResponse:

		rr := r

		ctx.JSON(http.StatusOK, gin.H{
			"status":  "success",
			"message": "Nickname Fetched",
			"data": gin.H{
				"nickname": rr.Nickname,
			},
		})

	default:

		return nil

	}

	return nil
}

func BaseSuccessResponse(successMessage string) gin.H {
	return gin.H{
		"status":  "success",
		"message": successMessage,
	}
}

func BaseSuccessResponseWithData(successMessage string, data interface{}) gin.H {
	return gin.H{
		"status":  "success",
		"message": successMessage,
		"data":    data,
	}
}

func BaseErrorResponse(errMessage string) gin.H {
	return gin.H{
		"status":  "failed",
		"message": errMessage,
	}
}
