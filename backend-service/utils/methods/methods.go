package methods

import (
	"encoding/base64"
	"fmt"
	"time"

	"github.com/google/uuid"
)

func GenerateRandomID() string {

	return uuid.New().String()
}

func GetCurrentTimestamp() int64 {

	currentTime := time.Now()

	// Get the Unix timestamp
	unixTimestamp := currentTime.Unix()

	return unixTimestamp
}

func DecodeBase64ToBytes(base64String string) ([]byte, error) {
	// Convert base64 string to bytes
	base64Bytes, err := base64.StdEncoding.DecodeString(base64String)
	if err != nil {
		return nil, fmt.Errorf("error decoding base64: %v", err)
	}

	return base64Bytes, nil

}
