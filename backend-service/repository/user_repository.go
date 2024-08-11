package repository

import (
	"context"
	"fmt"

	"cloud.google.com/go/firestore"
	"github.com/FusionLabInc/nanolearn/backend-service/bootstrap"
	"github.com/FusionLabInc/nanolearn/backend-service/domain"
)

const (
	usersModelName = "users"
)

type UserRepository interface {
	Get(c context.Context, userID string) *domain.User
	Add(c context.Context, userID string, data domain.User) bool
	FilterDb(c context.Context, field string, value string) *domain.User
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

func (ur *userRepository) Get(c context.Context, userID string) *domain.User {

	data, err := ur.clientColRef.Doc(userID).Get(c)

	if err != nil {
		fmt.Printf("error fetching user: %v", err)
		return nil
	}

	if !data.Exists() {
		fmt.Printf("error fetching user user exists: %v", err)
		return nil
	}

	var user *domain.User

	if err := data.DataTo(&user); err != nil {
		fmt.Printf("error fetching user user exists: %v", err)
		return nil
	}

	return user
}

func (ur *userRepository) Add(c context.Context, userID string, data domain.User) bool {

	userData := ur.Get(c, userID)

	if userData != nil {

		return true
	}

	userMap := make(map[string]interface{})

	userMap["created_at"] = data.CreatedAt

	userMap["id"] = data.ID

	userMap["username"] = data.Username

	_, newErr := ur.clientColRef.Doc(userID).Set(c, userMap)

	if newErr != nil {
		fmt.Printf("error adding user: %v", newErr)
		return false
	}

	return true
}

func (ur *userRepository) FilterDb(c context.Context, field string, value string) *domain.User {

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

	var user *domain.User

	if err := doc.DataTo(user); err != nil {
		return nil
	}

	return user
}
