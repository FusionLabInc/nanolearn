package domain

import "github.com/FusionLabInc/nanolearn/backend-service/utils/methods"

type User struct {
	ID        string `json:"id"`
	Username  string `json:"username"`
	CreatedAt int64  `json:"created_at"`
}

func GenerateUserID() string {

	return methods.GenerateRandomID()
}
