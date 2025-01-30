package main

import (
	"aoc-2015/lib"
	"fmt"
	"regexp"
	"strconv"
)

type mapping struct {
	Hash map[string]int
}

func (m mapping) KeysAbsent(keys ...string) bool {
	for _, key := range keys {
		_, ok := m.Hash[key]
		if !ok { return true }
	}
	return false
}

func main(){
	m := mapping{
		Hash: make(map[string]int),
	}
	data := lib.ReadInput("i.txt")
	dataSlice := lib.SplitLine(data)
	
	for {
		for i, line := range dataSlice {
			if parse(line, m) {
				dataSlice[i] = ""
			}
		}

		if allEmptyString(dataSlice){
			break
		}
	}

	fmt.Println(m.Hash["a"])
}

func parse(s string, m mapping) bool {
	h := m.Hash

	switch {
	case hasAnd(s):
		re := regexp.MustCompile(" -> | AND ")
	
		return write(m, re.Split(s, -1), and)
	case hasOr(s):
		re := regexp.MustCompile(" -> | OR ")
	
		return write(m, re.Split(s, -1), or)
	case hasLShift(s):
		re := regexp.MustCompile(" -> | LSHIFT ")
	
		return write(m, re.Split(s, -1), lshift)
	case hasRShift(s):
		re := regexp.MustCompile(" -> | RSHIFT ")
	
		return write(m, re.Split(s, -1), rshift)
	case hasNot(s):
		re := regexp.MustCompile(" -> |NOT ")
		slice := re.Split(s, -1)

		if m.KeysAbsent(slice[1]) { return false }

		h[slice[2]] = not(h[slice[1]])
		return true
	default:
		re := regexp.MustCompile(" -> ")
		slice := re.Split(s, -1)

		num, err := strconv.Atoi(slice[0])
				
		if err != nil {
			if m.KeysAbsent(slice[0]) { return false }

			h[slice[1]] = h[slice[0]]
		} else {
			h[slice[1]] = num
		}

		return true
	}
}

func write(m mapping, vars []string, operator func(num1, num2 int) int) bool {
	h := m.Hash
	s1 := vars[0]
	s2 := vars[1]
	s3 := vars[2]

	if onlyDigits(s1) && !onlyDigits(s2) {
		if m.KeysAbsent(s2) { return false }
		
		h[s3] = operator(lib.StrToInt(s1), h[s2])
		return true
	} else if !onlyDigits(s1) && onlyDigits(s2) {
		if m.KeysAbsent(s1) { return false }
		
		h[s3] = operator(h[s1], lib.StrToInt(s2))
		return true
	} else if !onlyDigits(s1) && !onlyDigits(s2) {
		if m.KeysAbsent(s1, s2) { return false }

		h[s3] = operator(h[s1], h[s2])
		return true
	} else {
		h[s3] = operator(lib.StrToInt(s1), lib.StrToInt(s2))
		return true
	}
}

func allEmptyString(s []string) bool {
	for _, el := range s {
		if el != "" {
			return false
		}
	}

	return true
}