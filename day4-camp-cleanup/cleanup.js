const { create } = require('domain');
const fs = require('file-system')

const input = fs.readFileSync('./input.txt').toString('utf-8')
const inputArr = input.split('\n').map(element => element.split(','));

const splitted = inputArr.map(element => {
  const map = element.map(string => {
    return string.split('-').map(el => parseInt(el))
  })
  return map
});

const createIntArr = (start, end) => {
  let arr = []
  for (let i = start; i <= end; i++) {
    arr.push(i)
  }
  return arr
}

for (let i = 0; i < splitted.length; i++) {
  for (let j = 0; j < splitted[i].length; j++) {
    splitted[i][j] = createIntArr(splitted[i][j][0], splitted[i][j][1])
  }
}

const compareArr = (arr1, arr2) => {
  if (arr1.length >= arr2.length){
    return arr2.every( el => (
      arr1.includes(el)
      ))
    } else if (arr1.length <= arr2.length){
    return arr1.every( el => (
      arr2.includes(el)
      ))
    }
}

const compareSomeArr = (arr1, arr2) => {
  if (arr1.length >= arr2.length){
    return arr2.some( el => (
      arr1.includes(el)
      ))
    } else if (arr1.length <= arr2.length){
    return arr1.some( el => (
      arr2.includes(el)
      ))
    }
}

// Part 1
const calculate = () => {
  let p1total = 0
  let p2total = 0

  for (let i = 0; i < splitted.length -1; i++) {
    // console.log(splitted[i]);
    if( compareArr(splitted[i][0], splitted[i][1] )){
      p1total++
    } else if ( compareSomeArr(splitted[i][0], splitted[i][1])){
      p2total++
    }
    
  }
  return `Part 1: ${p1total}, Part 2: ${p1total + p2total}`
}

console.log(calculate());


