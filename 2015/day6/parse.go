package main

import (
	"aoc-2015/lib"
	"regexp"
	"strings"
)

func parse(s string) (string, []int, []int) {
	re := regexp.MustCompile(`turn on|turn off|toggle`)
	coordRe := regexp.MustCompile(`\d+,\d+`)
	coords := coordRe.FindAllString(s, -1)

	from := lib.MapStrToInt(strings.Split(coords[0], ","))
	to := lib.MapStrToInt(strings.Split(coords[1], ","))

	return re.FindString(s), from, to
}