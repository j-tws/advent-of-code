package main

import (
	"aoc-2015/lib"
	"regexp"
	"strconv"
	"strings"
)

func parse(s string) (string, []int, []int) {
	re := regexp.MustCompile(`turn on|turn off|toggle`)
	coordRe := regexp.MustCompile(`\d+,\d+`)
	coords := coordRe.FindAllString(s, -1)

	from := lib.Map(strings.Split(coords[0], ","), strToInt)
	to := lib.Map(strings.Split(coords[1], ","), strToInt)

	return re.FindString(s), from, to
}

func strToInt(s string) int {
	num, _ := strconv.Atoi(s)
	return num
}