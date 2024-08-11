package validator

import (
	"fmt"
	"net/mail"

	"github.com/FusionLabInc/nanolearn/backend-service/pb"
)

// var (
// 	isValidUsername = regexp.MustCompile(`^[a-z0-9_]+$`).MatchString
// )

func ValidateString(fieldName string, value string, minLength int, maxLength int) error {
	n := len(value)
	if n < minLength || n > maxLength {
		return fmt.Errorf("%s must contain from %d-%d characters", fieldName, minLength, maxLength)
	}
	return nil
}

func ValidateNickname(value string) error {
	if err := ValidateString("nickname", value, 3, 100); err != nil {
		return err
	}
	// if !isValidUsername(value) {
	// 	return fmt.Errorf("must contain only lowercase letters, digits, or underscore")
	// }
	return nil
}

func ValidatePassword(value string) error {
	return ValidateString("password", value, 6, 100)
}

func ValidateEmail(value string) error {
	if err := ValidateString("email", value, 3, 200); err != nil {
		return err
	}
	if _, err := mail.ParseAddress(value); err != nil {
		return fmt.Errorf("is not a valid email address")
	}
	return nil
}

func ValidateLoginRequest(req *pb.LoginRequest) error {

	if err := ValidateNickname(req.GetNickname()); err != nil {
		return err
	}

	return nil
}

func ValidateRenewTokenRequest(req *pb.RenewTokenRequest) error {

	if err := ValidateString("token", req.GetRefreshToken(), 3, 2000); err != nil {
		return err
	}

	return nil
}
