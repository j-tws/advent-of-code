package main

import (
	"regexp"
)

func regCompile(pattern string, subject string) bool {
	re := regexp.MustCompile(pattern)
	return re.MatchString(subject)
}

func hasAnd(s string) bool {
	return regCompile("AND", s)
}

func hasOr(s string) bool {
	return regCompile("OR", s)
}

func hasLShift(s string) bool {
	return regCompile("LSHIFT", s)
}

func hasRShift(s string) bool {
	return regCompile("RSHIFT", s)
}

func hasNot(s string) bool {
	return regCompile("NOT", s)
}

func onlyDigits(s string) bool {
	re := regexp.MustCompile(`^[0-9]+$`)
	return re.MatchString(s)
}
