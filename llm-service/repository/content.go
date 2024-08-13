package repository

type MainContent struct {
	MainSection []MainSection `json:"main_sections"`
}

type MainSection struct {
	SectionTitle string            `json:"section_title"`
	Summary      map[string]string `json:"summary"`
	Charts       []Chart           `json:"charts"`
}

type Chart struct {
	SectionTitle string                   `json:"section_title"`
	Type         string                   `json:"type"`
	Description  string                   `json:"description"`
	Data         []map[string]interface{} `json:"data"`
}

type DetailedExplanation struct {
	Index   string `json:"index"`
	Content string `json:"content"`
}

type Example struct {
	Scenario    string `json:"scenario"`
	Description string `json:"description"`
	Relation    string `json:"relation"`
}

type Quiz struct {
	Question      string   `json:"question"`
	Type          string   `json:"type"`
	Options       []string `json:"options"`
	CorrectAnswer string   `json:"correct_answer"`
}

type Section struct {
	SectionTitle         string            `json:"section_title"`
	Summary              string            `json:"summary"`
	DetailedExplanations map[string]string `json:"detailed_explanations"`
	Examples             []Example         `json:"examples"`
	Quizzes              []Quiz            `json:"quiz"`
}

type GlossaryContent struct {
	Glossary Glossary `json:"glossary"`
}

type Glossary struct {
	A []*TermDefinition `json:"A"`
	B []*TermDefinition `json:"B"`
	C []*TermDefinition `json:"C"`
	D []*TermDefinition `json:"D"`
	E []*TermDefinition `json:"E"`
	F []*TermDefinition `json:"F"`
	G []*TermDefinition `json:"G"`
	H []*TermDefinition `json:"H"`
	I []*TermDefinition `json:"I"`
	K []*TermDefinition `json:"K"`
	L []*TermDefinition `json:"L"`
	M []*TermDefinition `json:"M"`
	N []*TermDefinition `json:"N"`
	O []*TermDefinition `json:"O"`
	P []*TermDefinition `json:"P"`
	Q []*TermDefinition `json:"Q"`
	R []*TermDefinition `json:"R"`
	S []*TermDefinition `json:"S"`
	T []*TermDefinition `json:"T"`
	U []*TermDefinition `json:"U"`
	V []*TermDefinition `json:"V"`
	W []*TermDefinition `json:"W"`
	X []*TermDefinition `json:"X"`
	Y []*TermDefinition `json:"Y"`
	Z []*TermDefinition `json:"Z"`
}

type TermDefinition struct {
	Term       string `json:"term"`
	Definition string `json:"definition"`
}
