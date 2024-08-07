package repository

import (
	"context"
	"fmt"

	"cloud.google.com/go/firestore"
	"github.com/FusionLabInc/nanolearn/backend-service/bootstrap"
)

const (
	usersModelName = "users"
)

type UserRepository interface {
	Get(c context.Context, userID string) map[string]interface{}
	Add(c context.Context, userID string, data interface{}) bool
	FilterDb(c context.Context, field string, value string) map[string]interface{}
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

func (ur *userRepository) Get(c context.Context, userID string) map[string]interface{} {

	var userData map[string]interface{}

	data, err := ur.clientColRef.Doc(userID).Get(c)

	if err != nil {
		fmt.Printf("error fetching user: %v", err)
		return nil
	}

	if !data.Exists() {
		fmt.Printf("error fetching user user exists: %v", err)
		return nil
	}

	userData = data.Data()

	return userData
}

func (ur *userRepository) Add(c context.Context, userID string, data interface{}) bool {

	userData := ur.Get(c, userID)

	if userData == nil {

		fmt.Print("error adding user as user already exists")

		return false
	}

	_, err := ur.clientColRef.Doc(userID).Set(c, data)

	if err != nil {
		fmt.Printf("error adding user: %v", err)
		return false
	}

	return true
}

func (ur *userRepository) FilterDb(c context.Context, field string, value string) map[string]interface{} {

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

	userData = doc.Data()

	return userData
}
