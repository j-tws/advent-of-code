const fs = require('file-system')

const input = fs.readFileSync('./input.txt').toString('utf-8')
const inputArr = input.split('\n').map(element => element.split(',').join());
const [a, b, c, d, e, f, g, h, stackNum, empty, ...instructions] = inputArr
const replaceInstruction = instructions.map( instruction => instruction.replace(/\D/g, ''))

const createStacks = () => {
  let stacks = {}
  const group = [...stackNum].filter( el => el !== ' ')
  const startStack = [a, b, c, d, e, f, g, h]

  const mappedStack = startStack.map( element => (
    element
      .replace(/    /gi, ' ')
      .split(' ')
      .map( element => element.replace(/[\[\]']+/g,''))
  )).reverse()

  for (let i = 0; i < group.length; i++) {
    stacks[group[i]] = []
  }

  for (let j = 0; j < mappedStack.length; j++) {
    let stackEl = mappedStack[j]

    for (let k = 0; k < stackEl.length; k++) {
      if (!stackEl[k]){
        continue
      }
      stacks[ (k + 1 ).toString() ].push( stackEl[k] )
    }

  }
  return stacks
}

let givenStack = createStacks();

const moveStack = () => {
  let moveAmount;
  let start;
  let end;
  for (let i = 0; i < replaceInstruction.length; i++) {
    let number = replaceInstruction[i]

    if (replaceInstruction[i].length === 4){

      moveAmount = number.substring(0,2)
      start = number[2]
      end = number[3]
    } else {
      moveAmount = number.substring(0,1)
      start = number[1]
      end = number[2]
    }
    
    let movedCrate = givenStack[start].splice( givenStack[start].length - moveAmount, givenStack[start].length )

    // PART 1 - USE REVERSE.()
    givenStack[end] = [...givenStack[end], ...movedCrate.reverse()]
    // FOR PART 2 - OMIT REVERSE.()
    // givenStack[end] = [...givenStack[end], ...movedCrate]

  }

  let lastChar = []
  for (const key in givenStack){
    let array = givenStack[key]
    lastChar.push(array[array.length - 1])
  }
  return lastChar.join()
}

console.log(moveStack())

