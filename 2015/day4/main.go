package main

import (
	"crypto/md5"
	"encoding/hex"
	"fmt"
	"strconv"
	"strings"
)

const (
	key = "ckczppom"
	prefixP1 = "00000"
	prefixP2 = "000000"
)

func main(){
	input := make(chan string)
	output := make(chan string)

	go generator(input)
	for i := 0; i < 5; i++ {
		go processor(input, output)
	}

	fmt.Println(<-output)	
}

func generator(ch chan<- string){
	for i := 0; ; i++ {
		ch <- key + strconv.Itoa(i)
	}
}

func processor(in <-chan string, out chan string){
	for {
		key := <- in
		hash := md5.Sum([]byte(key))
		hexString := hex.EncodeToString(hash[:])
		
		if strings.HasPrefix(hexString, prefixP2) {
			out <- key
			return
		}
	}
}
