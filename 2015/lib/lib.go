package lib

import (
	"fmt"
	"io"
	"os"
)

func ReadInput(path string) string {
	file, err := os.Open(path)

	if err != nil {
		fmt.Println(err)
	}

	data, _ := io.ReadAll(file)

	return string(data)
}