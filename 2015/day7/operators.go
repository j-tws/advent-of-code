package main

import "fmt"

func and(num1, num2 int) int{
	return num1 & num2
}

func or(num1, num2 int) int {
	return num1 | num2
}

func lshift(num1, num2 int) int {
	return num1 << (num2 % 64)
}

func rshift(num1, num2 int) int {
	fmt.Println(num1, num2, num1 >> (num2 % 64))
	return num1 >> (num2 % 64)
}

func not(num int) int {
	return int(^uint16(num))
}