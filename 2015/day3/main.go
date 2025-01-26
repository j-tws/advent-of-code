package main

import (
	"aoc-2015/lib"
	"fmt"
	"slices"
	"strings"
)

type pos struct{
	x int
	y int
}

func (p *pos) Move(direction string) {
	switch direction {
	case "^":
		p.y += 1
	case ">":
		p.x += 1
	case "v":
		p.y -= 1
	case "<":
		p.x -= 1
	default:
		fmt.Printf("No such position: %s", direction)
	}
}

func p2 (actions []string) {
	history := []pos{{x: 0, y: 0}}
	total := 1
	
	// santas movement
	santaCurrentPos := pos{x: 0, y: 0}
	calcPresents(actions, 0, 2, santaCurrentPos, &history, &total)

	// robos movement
	roboCurrentPos := pos{x: 0, y: 0}
	calcPresents(actions, 1, 2, roboCurrentPos, &history, &total)

	fmt.Println(total)
}

func main(){
	data := lib.ReadInput("i.txt")
	actions := strings.Split(data, "")
	
	history := []pos{{x: 0, y: 0}}
	currentPos := pos{x: 0, y: 0}
	total := 1
	
	calcPresents(actions, 0, 1, currentPos, &history, &total)
	fmt.Println(total) // part 1
	
	p2(actions) // part 2
}

func calcPresents(actions []string, start int, interval int, p pos, history *[]pos, total *int) {
	for i := start; i < len(actions); i += interval {
		p.Move(actions[i])
		if !slices.Contains(*history, p){
			*total++
		}
		*history = append(*history, p)
	}
}
