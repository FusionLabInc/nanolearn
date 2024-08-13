package domain

import "github.com/FusionLabInc/nanolearn/backend-service/utils/methods"

type User struct {
	ID        string    `json:"id"`
	Username  string    `json:"username"`
	CreatedAt int64     `json:"created_at"`
	Contents  []Content `json:"contents"`
}

type Content struct {
	ID       string `json:"id"`
	FileName string `json:"file_name"`
	Size     uint32 `json:"size"`
}

func GenerateUserID() string {

	return methods.GenerateRandomID()
}
