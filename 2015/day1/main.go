package main

import (
	"fmt"
	"strings"
	"aoc-2015/lib"
)

func main() {
	data := lib.ReadInput("i.txt")
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
