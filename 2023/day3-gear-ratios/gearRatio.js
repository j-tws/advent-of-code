import { getInput } from "../utils.js"

const parseInput = () => {
  return getInput('input.txt').split('\n')
}

const findSymbols = (data) => {
  const symbols = getInput('input.txt').replace(/[\d\.\s]/g, '')
  return [...new Set(symbols.split(''))]
}

const findDigits = (data) => {
  const digits = []
  const symbols = findSymbols(parseInput())
  let nearSymbol = false

  for (let i = 0; i < data.length; i++) {
    let pos = 0
    let digit = ''
    while (pos < data[i].length){
      let current = data[i][pos]
      if (/\d/.test(current)){
        digit += current

        if (i > 0){
          if (symbols.includes(data[i - 1][pos - 1]) ||
          symbols.includes(data[i - 1][pos]) ||
          symbols.includes(data[i - 1][pos + 1])
          ) {
            nearSymbol = true
          }
        }

        if (symbols.includes(data[i][pos - 1]) ||
        symbols.includes(data[i][pos + 1]) ||
        symbols.includes(data[i + 1][pos - 1]) ||
        symbols.includes(data[i + 1][pos]) ||
        symbols.includes(data[i + 1][pos + 1])
        ) {
          nearSymbol = true
        }
        
        if (!/\d/.test(data[i][pos + 1] )){
          if (nearSymbol){
            digits.push(digit)
            digit = ''
            nearSymbol = false
          } else {
            digit = ''
          }
        }
      } 
      pos++
    }
  }
  return digits.map(digit => parseInt(digit)).reduce((acc, curr) => curr + acc, 0)
}

const findMultiplesWithinMatrix = (matrix) => {
  const digits = []
  let nearSymbol = false
  let digit = ''

  const modifiedMatrix = matrix.map(arr => arr.split(''))
  for (let i = 0; i < modifiedMatrix.length; i++) {
    for (let j = 0; j < modifiedMatrix[i].length; j++) {
      let current = modifiedMatrix[i][j]
      
      if (current === '*'){
        if (i !== 1 || j !== 3){
          modifiedMatrix[i][j] = '.'
        }
      }
    }
  }

  for (let i = 0; i < modifiedMatrix.length; i++) {

    for (let j = 0; j < modifiedMatrix[i].length; j++) {
      let current = modifiedMatrix[i][j]

      if (/\d/.test(current)){
        if (i > 0){
          if (modifiedMatrix[i - 1][j - 1] === '*' ||
          modifiedMatrix[i - 1][j] === '*' ||
          modifiedMatrix[i - 1][j + 1] === '*'
          ) {
            nearSymbol = true
          }
        }

        if (modifiedMatrix[i][j - 1] === '*' ||
        modifiedMatrix[i][j + 1] === '*'){
          nearSymbol = true
        }

        if (i < modifiedMatrix.length - 1){
          if ( modifiedMatrix[i + 1][j - 1] === '*' ||
          modifiedMatrix[i + 1][j] === '*' ||
          modifiedMatrix[i + 1][j + 1] === '*'
          ) {
          nearSymbol = true
          }
        }

        digit += current
      }

      if (!/\d/.test(modifiedMatrix[i][j + 1] )){
        if (nearSymbol){
          digits.push(digit)
          digit = ''
          nearSymbol = false
        } else {
          digit = ''
        }
      }
    }
  }
  return digits[0] * digits[1]
}

const findDigitsWithGear = (data) => {
  const digits = []

  for (let i = 0; i < data.length; i++) {
    for (let j = 0; j < data[i].length; j++) {
      let current = data[i][j]
      if (current !== '*'){
        continue
      }

      const surroudingElement = [
        [i > 0 ? data[i - 1][j - 1] : null, i > 0 ? data[i - 1][j] : null, i > 0 ? data[i - 1][j + 1] : null],
        [data[i][j - 1], current, data[i][j + 1]],
        [data[i + 1][j - 1], data[i + 1][j], data[i + 1][j + 1]]
      ]

      const joinedSurrounding = (surroudingElement.map(a => a.join('')).join('\n'))
      if (joinedSurrounding.match(/\d+/g).length !== 2){
        continue
      }

      const matrix = [data[i - 1].slice(j - 3, j + 4), data[i].slice(j - 3, j + 4), data[i + 1].slice(j - 3, j + 4)]

      digits.push(findMultiplesWithinMatrix(matrix))
    }
  }
  
  return digits.reduce((acc, curr) => acc + curr, 0)
}

console.log(findDigits(parseInput()))
console.log(findDigitsWithGear(parseInput()))