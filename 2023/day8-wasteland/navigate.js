import { getInput } from "../utils.js"

const parsedInput = (filePath) => {
  const parsed = getInput(filePath).split('\n')
  const steps = parsed[0].split('').map(step => step === 'L' ? 0 : 1)
  const nodes = parsed.slice(2, parsed.length).map( node => {
    const splitted = node.split(' = ')
    splitted[1] = splitted[1].match(/\w+/g)
    return splitted
  })
  return {steps, nodes: Object.fromEntries(nodes)}
}

const calculateSteps = ({steps, nodes}) => {
  let start = 'AAA'
  let count = 0

  while (start !== 'ZZZ'){
    for (let i = 0; i < steps.length; i++) {
      start = nodes[start][steps[i]]
      count++

      if (i === steps.length){
        i = 0
      }
    }
  }

  return count
}

const calculateStepsP2 = (start, {steps, nodes}) => {
  let count = 0

  while (!start.endsWith('Z')){
    for (let i = 0; i < steps.length; i++) {
      start = nodes[start][steps[i]]
      count++
      if (i === steps.length){
        i = 0
      }
    }
  }

  return count
}

const calculateStepsForAll = (data) => {
  const startPoints = Object.keys(data.nodes).filter(node => node[2] === 'A')
  const mappedToCounts = startPoints.map(point => {
    return calculateStepsP2(point, data)
  })

  return mappedToCounts
}

// Plucked this out from geeksforgeeks. take the time to study!
const lcm = (a, b) => {
  let larger = Math.max(a, b)
  let smaller = Math.min(a, b)
  for (let i = larger; ; i += larger) {
    if (i % smaller === 0){
      return i
    }
  }
}

const lcmGroup = (numArr) => numArr.reduce(lcm, 1)

const data = parsedInput('input.txt')
console.log(calculateSteps(data))

console.log(lcmGroup(calculateStepsForAll(data)))