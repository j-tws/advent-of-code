import { getInput, sum } from "../utils.js"

const parsedInput = (filePath) => {
  return getInput(filePath).split('\n').map(line => {
    const splitted = line.split(' ')
    splitted[1] = splitted[1].match(/\d+/g).map(num => parseInt(num))
    return splitted
  })
}

const findPermutations = (array) => {
  let result = []
  if (array.length === 0) return []
  if (array.length === 1) return [array]
  
  for (let i = 0; i < array.length; i++) {
    const current = array[i];
    const remaining = [...array]
    remaining.splice(i, 1)
    
    const remainingPermuted = findPermutations(remaining)
    for (let j = 0; j < remainingPermuted.length; j++) {
      const permutedArray = [current].concat(remainingPermuted[j])
      result.push(permutedArray)
    }
  }
  return [...new Set(result.map(res => res.join('')))]
}

const calculatePermutation = ([condition, report]) => {
  const hashAmount = condition.split('').filter(el => el === '#').length
  const totalHash = sum(report)
  const hashNeeded = totalHash - hashAmount


}


const data = parsedInput('test-input.txt')
// console.log(calculatePermutation([ '???.###', [ 1, 1, 3 ] ]))
console.log(findPermutations('#..'.split('')))
// WAHHHHHHHHH
