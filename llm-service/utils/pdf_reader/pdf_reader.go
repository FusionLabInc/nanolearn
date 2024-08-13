package pdf_reader

import (
	"bytes"
	"io/ioutil"
	"log"
	"os"

	"github.com/unidoc/unipdf/v3/extractor"
	pdf "github.com/unidoc/unipdf/v3/model"
)

func ReadPdf(filePath string) *string {

	file, err := os.Open(filePath)
	if err != nil {
		log.Fatal(err)
		return nil
	}
	defer file.Close()
	buf, err := ioutil.ReadAll(file)
	if err != nil {
		log.Fatal(err)
		return nil
	}
	pdfReader, err := pdf.NewPdfReader(bytes.NewReader(buf))
	if err != nil {
		log.Fatal(err)
		return nil
	}

	numPages, err := pdfReader.GetNumPages()
	if err != nil {
		log.Fatal(err)
		return nil
	}

	var finalText string = ""
	for i := 1; i <= numPages; i++ {

		page, err := pdfReader.GetPage(i)
		if err != nil {
			log.Fatal(err)
			return nil
		}
		ex, err := extractor.New(page)
		if err != nil {
			log.Fatal(err)
			return nil
		}
		text, err := ex.ExtractText()
		if err != nil {
			log.Fatal(err)
			return nil
		}

		finalText = finalText + text
	}

	return &finalText

}
