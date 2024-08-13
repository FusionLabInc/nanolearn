package repository

type Repository struct {
	User    UserRepository
	Content ContentRepository
}
