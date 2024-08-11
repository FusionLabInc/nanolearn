package bootstrap

type Application struct {
	Env *Env
	Llm *Llm
}

func App() Application {
	app := &Application{}
	app.Env = NewEnv()
	app.Llm = NewLLm(app.Env)

	return *app
}
