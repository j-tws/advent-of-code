package lib

import (
	"fmt"
	"io"
	"os"
	"regexp"
	"strconv"
)

func ReadInput(path string) string {
	file, err := os.Open(path)

	if err != nil {
		fmt.Println(err)
	}

	data, _ := io.ReadAll(file)

	return string(data)
}

func SplitLine(input string) []string {
	return regexp.MustCompile(`\n`).Split(input, -1)
}

func MapStrToInt(s []string) []int{
	intSlice := []int{}
	for _, str := range s {
		num, _ := strconv.Atoi(str)
		intSlice = append(intSlice, num)
	}
	return intSlice
}

func Map[T any, U any](slice []T, callback func(T) U) []U {
	newSlice := []U{}

	for _, el := range slice {
		newSlice = append(newSlice, callback(el))
	}

	return newSlice
}
