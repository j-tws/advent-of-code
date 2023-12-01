const fs = require('file-system')

const input = fs.readFileSync('./input.txt').toString('utf-8')
// const testStr = 'nppdvjthqldpwncqszvftbrmjlhg'

const getMarker = (string, charAmount) => {
  for (let i = 0; i < string.length; i++) {
    const marker = string.slice(i, i + charAmount)
    if(!( /(.).*\1/.test(marker) )){
      return i + charAmount
    }
  }
}

// Part 1
console.log(getMarker(input, 4));

// Part 2
console.log(getMarker(input, 14));
