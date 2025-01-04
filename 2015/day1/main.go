package main

import (
	"fmt"
	"io"
	"os"
	"strings"
)

func readInput(path string) string {
	file, err := os.Open(path)

	if err != nil {
		fmt.Println(err)
	}

	data, _ := io.ReadAll(file)

	return string(data)
}

func main() {
	data := readInput("i.txt")
	slice := strings.Split(data, "")
	sum := 0

	for i := 0; i < len(slice); i++ {
		if slice[i] == "(" {
			sum++
		} else {
			sum--
		}

		if sum < 0 {
			fmt.Println(i + 1)
			break
		}
	}

	fmt.Println(sum)
}
