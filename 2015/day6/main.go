package main

import (
	"aoc-2015/lib"
	"fmt"
)

const (
	size = 1000
)

type light struct{
	on bool
	brightness int
}

func (l *light) toggle(){
	l.on = !l.on
	l.brightness += 2
}

func (l *light) turnOff(){
	l.on = false
	if l.brightness > 0 {
		l.brightness -= 1
	}
}

func (l *light) turnOn(){
	l.on = true
	l.brightness += 1
}

func grid() [][]light {
	grid := [][]light{}

	for i := 0; i < size; i++ {
		row := []light{}

		for j :=0 ; j < size ; j++ {
			row = append(row, light{on: false, brightness: 0})
		}
		grid = append(grid, row)
	}
	return grid	
}

func main(){
	data := lib.ReadInput("i.txt")
	dataSlice := lib.SplitLine(data)
	g := grid()

	for _, line := range dataSlice {
		command, from, to := parse(line)
		
		for i := from[0]; i <= to[0]; i++ {
			for j := from[1]; j <= to[1]; j++ {
				if command == "toggle" {
					g[j][i].toggle()
				} else if command == "turn on" {
					g[j][i].turnOn()
				} else {
					g[j][i].turnOff()
				}
			}
		}
	}

	fmt.Println(countLightsOn(g)) // part 1
	fmt.Println(calcBrightness(g)) // part 2

}

func countLightsOn(grid [][]light) int {
	total := 0
	for _, row := range grid {
		for _, l := range row {
			if l.on { total++ }
		}
	}
	return total
}

func calcBrightness(grid [][]light) int {
	total := 0
	for _, row := range grid {
		for _, l := range row {
			total += l.brightness
		}
	}
	return total
}
