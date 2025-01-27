package main

import (
	"aoc-2015/lib"
	"fmt"
	"regexp"
	"slices"
	"strings"
)

func vowels() []string {
	return []string{"a", "e", "i", "o", "u"}
}

func invalidString() [] string {
	return []string{"ab", "cd", "pq", "xy"}
}

func main(){
	data := lib.ReadInput("i.txt")
	dataSlice := splitLine(data)
	niceStringCountP1 := 0
	niceStringCountP2 := 0

	for _, line := range dataSlice {
		if validateNiceString(line) {
			niceStringCountP1++
		}

		if validateNiceStringP2(line) {
			niceStringCountP2++
		}
	}

	fmt.Println(niceStringCountP1) // part 1
	fmt.Println(niceStringCountP2) // part 2
}

func splitLine(input string) []string {
	return regexp.MustCompile(`\n`).Split(input, -1)
}

func validateNiceString(s string) bool {
	slice := strings.Split(s, "")
	vowelsCount := 0
	hasTwoRepeatedString := false

	for i := 0; i < len(slice); i++ {
		currentChar := slice[i]

		if slices.Contains(vowels(), currentChar) {
			vowelsCount++
		}

		if i + 1 >= len(slice) {
			return vowelsCount >= 3 && hasTwoRepeatedString
		}

		if slices.Contains(invalidString(), slice[i] + slice[i+1]) {
			return false
		}

		if slice[i] == slice[i+1] {
			hasTwoRepeatedString = true
		}
	}

	return vowelsCount >= 3 && hasTwoRepeatedString
}

func validateNiceStringP2(s string) bool {
	slice := strings.Split(s, "")
	hasRepeatingPairs := false
	hasRepeatsBetweenLetters := false
	
	for i := 0; i < len(slice); i++ {
		if i + 1 >= len(slice) || i + 2 >= len(slice) {
			return hasRepeatingPairs && hasRepeatsBetweenLetters
		}

		if slice[i] == slice [i+2] {
			hasRepeatsBetweenLetters = true
		}

		firstPair := slice[i] + slice[i+1]
		
		for j := i + 2; j < len(slice); j++ {
			if j + 1 >= len(slice) { break }
			
			nextPair := slice[j] + slice[j+1]
			
			if firstPair == nextPair {
				hasRepeatingPairs = true
			}
		}
	}

	return hasRepeatingPairs && hasRepeatsBetweenLetters
}
