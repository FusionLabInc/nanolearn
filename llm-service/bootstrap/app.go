package bootstrap

type Application struct {
	Env *Env
	Llm *Llm
	Db  *Database
}

func App() Application {
	app := &Application{}
	app.Env = NewEnv()
	app.Llm = NewLLm(app.Env)
	app.Db = NewDatabase(app.Env)

	return *app
}
