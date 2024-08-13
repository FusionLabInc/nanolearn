package repository

import (
	"context"
	"fmt"

	"cloud.google.com/go/firestore"
	"github.com/FusionLabInc/nanolearn/llm-service/bootstrap"
)

const (
	usersModelName = "users"
)

type UserRepository interface {
	Get(c context.Context, userID string) *User
	Add(c context.Context, userID string, data User) bool
	Update(c context.Context, userID string, data User) bool
	FilterDb(c context.Context, field string, value string) *User
}

type userRepository struct {
	clientColRef *firestore.CollectionRef
	modelName    string
}

func NewUserRepository(db *bootstrap.Database) UserRepository {

	clientColRef := db.Client.Collection(usersModelName)

	return &userRepository{
		clientColRef: clientColRef,
		modelName:    usersModelName,
	}
}

func (ur *userRepository) Get(c context.Context, userID string) *User {

	data, err := ur.clientColRef.Doc(userID).Get(c)

	if err != nil {
		fmt.Printf("error fetching user: %v", err)
		return nil
	}

	if !data.Exists() {
		fmt.Printf("error fetching user user exists: %v", err)
		return nil
	}

	var user *User

	if err := data.DataTo(&user); err != nil {
		fmt.Printf("error fetching user user exists: %v", err)
		return nil
	}

	return user
}

func (ur *userRepository) Add(c context.Context, userID string, data User) bool {

	userData := ur.Get(c, userID)

	if userData != nil {

		return false
	}

	userMap := make(map[string]interface{})

	userMap["created_at"] = data.CreatedAt

	userMap["id"] = data.ID

	userMap["username"] = data.Username

	userMap["contents"] = data.Contents

	_, newErr := ur.clientColRef.Doc(userID).Set(c, userMap)

	if newErr != nil {
		fmt.Printf("error adding user: %v", newErr)
		return false
	}

	return true
}

func (ur *userRepository) Update(c context.Context, userID string, data User) bool {

	userMap := make(map[string]interface{})

	userMap["created_at"] = data.CreatedAt

	userMap["id"] = data.ID

	userMap["username"] = data.Username

	userMap["contents"] = data.Contents

	_, newErr := ur.clientColRef.Doc(userID).Set(c, userMap)

	if newErr != nil {
		fmt.Printf("error adding user: %v", newErr)
		return false
	}

	return true
}

func (ur *userRepository) FilterDb(c context.Context, field string, value string) *User {

	var userData map[string]interface{}

	query := ur.clientColRef.Where(field, "==", value)

	docs, err := query.Documents(c).GetAll()

	if err != nil {
		fmt.Printf("error initializing database: %v", err)
		return nil
	}

	if len(userData) == 0 {
		return nil
	}

	doc := docs[0]

	var user *User

	if err := doc.DataTo(user); err != nil {
		return nil
	}

	return user
}
