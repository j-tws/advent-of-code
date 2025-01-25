package main

import (
	"aoc-2015/lib"
	"fmt"
	"regexp"
	"sort"
	"strconv"
)

func main(){
	data := lib.ReadInput("i.txt")
	slice := splitLine(data)
	parsed := [][]string{}
	
	for _, line := range slice {
		re := regexp.MustCompile((`x`))
		parsed = append(parsed, re.Split(line, -1))
	}

	fmt.Println(ribbonNeeded(parsed, calcWrapping)) // p1 answer
	fmt.Println(ribbonNeeded(parsed, calcWrappingP2)) // p2 answer
}

func splitLine(input string) []string {
	return regexp.MustCompile(`\n`).Split(input, -1)
}

func mapSlice(slice []string) []int {
	mapped := []int{}

	for _, str := range slice {
		num, _ := strconv.Atoi(str)
		mapped = append(mapped, num)
	}
	return mapped
}

func ribbonNeeded (dimensionSlice [][]string, wrapCalculator func([]string) int) int {
	total := 0
	for _, s := range dimensionSlice {
		total += wrapCalculator(s)
	}
	return total
}

func calcWrapping(dimensions []string) int {
	nums := mapSlice(dimensions)
	areaSlice := calcArea(nums)
	
	return areaSlice[0] * 2 + areaSlice[1] * 2 + areaSlice[2] * 2 + areaSlice[0]
}

func calcWrappingP2(dimensions []string) int {
	nums := mapSlice(dimensions)
	leastPerimeter := calcPerimeter(nums)[0]

	return leastPerimeter + nums[0] * nums[1] * nums[2]
}

func calcArea(dimensions []int) []int {
	slice := []int{
		dimensions[0] * dimensions[1],
		dimensions[1] * dimensions[2],
		dimensions[0] * dimensions[2],
	}
	sort.Ints(slice)
	return slice
}

func calcPerimeter(dimensions []int) []int {
	slice := []int{
		dimensions[0] * 2 + dimensions[1] * 2,
		dimensions[1] * 2 + dimensions[2] * 2,
		dimensions[0] * 2 + dimensions[2] * 2,
	}
	sort.Ints(slice)
	return slice
}