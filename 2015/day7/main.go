package main

import (
	"aoc-2015/lib"
	"fmt"
	"regexp"
	"strconv"
)

func main(){
	m := make(map[string]int)
	data := lib.ReadInput("i.txt")
	dataSlice := lib.SplitLine(data)
	
	for {
		for i, line := range dataSlice {
			ok := parse(line, m)
			if ok {
				dataSlice[i] = ""
			}
		}

		if allEmptyString(dataSlice){
			break
		}
	}

	fmt.Println(m["a"])
}

func parse(s string, m map[string]int) bool {
	if hasAnd(s) {
		re := regexp.MustCompile(" -> | AND ")
		slice := re.Split(s, -1)

		success := write(m, slice[0], slice[1], slice[2], and)
		return success
	} else if hasOr(s) {
		re := regexp.MustCompile(" -> | OR ")
		slice := re.Split(s, -1)
		success := write(m, slice[0], slice[1], slice[2], or)
		return success
	} else if hasLShift(s) {
		re := regexp.MustCompile(" -> | LSHIFT ")
		slice := re.Split(s, -1)
		success := write(m, slice[0], slice[1], slice[2], lshift)
		return success
	} else if hasRShift(s) {
		re := regexp.MustCompile(" -> | RSHIFT ")
		slice := re.Split(s, -1)
		success := write(m, slice[0], slice[1], slice[2], rshift)
		return success
	} else if hasNot(s) {
		re := regexp.MustCompile(" -> |NOT ")
		slice := re.Split(s, -1)

		_, ok := m[slice[1]]
		if !ok { return false }

		m[slice[2]] = not(m[slice[1]])
		return true
	} else {
		re := regexp.MustCompile(" -> ")
		slice := re.Split(s, -1)

		num, err := strconv.Atoi(slice[0])
				
		if err != nil {
			_, ok := m[slice[0]]
			if !ok { return false }

			m[slice[1]] = m[slice[0]]
		} else {
			m[slice[1]] = num
		}

		return true
	}
}

func keyAbsent(k string, m map[string]int) bool {
	_, ok := m[k]
	return !ok
}

func keysAbsent(k1, k2 string, m map[string]int) bool {
	_, firstOk := m[k1]
	_, secondOk := m[k2]

	return !firstOk || !secondOk
}

func write(m map[string]int, s1, s2, s3 string, operator func(num1, num2 int) int) bool {
	if onlyDigits(s1) && !onlyDigits(s2) {
		if keyAbsent(s2, m) { return false }
		
		m[s3] = operator(lib.StrToInt(s1), m[s2])
		return true
	} else if !onlyDigits(s1) && onlyDigits(s2) {
		if keyAbsent(s1, m) { return false }
		
		m[s3] = operator(m[s1], lib.StrToInt(s2))
		return true
	} else if !onlyDigits(s1) && !onlyDigits(s2) {
		if keysAbsent(s1, s2, m) { return false }

		m[s3] = operator(m[s1], m[s2])
		return true
	} else {
		m[s3] = operator(lib.StrToInt(s1), lib.StrToInt(s2))
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