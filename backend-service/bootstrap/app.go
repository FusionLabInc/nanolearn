package bootstrap

type Application struct {
	Env     *Env
	Db      *Database
	Storage *Storage
}

func App() Application {
	app := &Application{}
	app.Env = NewEnv()
	app.Db = NewDatabase(app.Env)
	app.Storage = NewStorage(app.Env)
	return *app
}
