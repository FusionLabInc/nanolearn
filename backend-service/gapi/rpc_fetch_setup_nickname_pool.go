package gapi

import (
	"context"

	"github.com/FusionLabInc/nanolearn/backend-service/utils/api_response"

	"github.com/FusionLabInc/nanolearn/backend-service/pb"
)

func (s *Server) FetchSetupNicknamePool(ctx context.Context, req *pb.FetchSetupNicknamePoolRequest) (*pb.FetchSetupNicknamePoolResponse, error) {

	nicknameList := []string{"Coding", "Music", "Travel", "Food", "Nature", "Reading", "Writing", "Gaming", "Cooking", "Gardening",
		"Photography", "Crafting", "Dancing", "Collecting", "Sports", "Soccer", "Basketball", "Tennis", "Swimming", "Hiking",
		"Creative", "Funny", "Adventurous", "Intelligent", "Calm", "Happy", "Sad", "Angry", "Excited", "Surprised",
		"Strong", "Confident", "Shy", "Curious", "Determined", "Cat", "Dog", "Bird", "Wolf", "Lion", "Forest",
		"Ocean", "Mountain", "River", "Sky", "Coffee", "Book", "Computer", "Phone", "Car", "Love", "Hope",
		"Freedom", "Peace", "Chaos", "Red", "Blue", "Green", "Yellow", "Purple", "Buzz", "Click", "Whisper",
		"Roar", "Hum", "Star", "Moon", "Fire", "Ice", "Dream", "Shadow", "Light", "Storm", "Rain", "Sun",
		"Earth", "Space", "Time", "Infinity", "Mystery", "Magic", "Power", "Energy", "Spirit", "Soul", "Mind",
		"Heart", "Life", "Death", "Truth", "Lies", "Fear", "Courage", "Joy", "Sadness", "Anger", "Love", "Hate",
		"Hope", "Despair"}

	return api_response.Success(&pb.FetchSetupNicknamePoolResponse{}, "User successfully registered", map[string]interface{}{
		"nicknames": nicknameList,
	}).(*pb.FetchSetupNicknamePoolResponse), nil

}
