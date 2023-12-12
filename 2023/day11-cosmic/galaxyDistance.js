import { getInput } from "../utils.js"

const parsedInput = (filePath) => {
  return getInput(filePath).split('\n').map(row => row.split(''))
}

const inputColumns = (data) => {
  const columns = Array.from(Array(data[0].length), () => [])
  
  for (let row = 0; row < data.length; row++) {
    for (let col = 0; col < data[row].length; col++) {
      const current = data[row][col]
      columns[col].push(current)
    }
  }

  return columns
}

const allDotsIndexes = (rows) => {
  const indexes = rows.reduce((acc, curr, index) => {
    if (curr.every(el => el === '.')){
      acc.push(index)
    }
    return acc
  }, [])

  return indexes
}


const galaxiesCoords = (matrix) => {
  let coords = []
  
  for (let row = 0; row < matrix.length; row++) {
    for (let col = 0; col < matrix[row].length; col++) {
      const current = matrix[row][col]
      if (current !== '.'){
        coords.push([row, col])
      }
    }
  }
  
  return coords
}

const mapCoordsWithExpansion = (coords, allDotRows, allDotCols) => {
  return coords.map(([x, y]) => {
    let newX = x
    let newY = y
    for (let i = 0; i < allDotRows.length; i++) {
      if (x > allDotRows[i]){
        // for first solution just newX + 1
        newX = newX + 1000000 - 1
      }
    }

    for (let i = 0; i < allDotCols.length; i++) {
      if (y > allDotCols[i]){
        // for first solution just newX + 1
        newY = newY + 1000000 - 1
      }
      
    }
    return [newX, newY]
  })
}


const findShortestDistance = (coord1, coord2) => {
  const horizontals = [coord1[0], coord2[0]].sort((a, b) => a - b)
  const verticals = [coord1[1], coord2[1]].sort((a, b) => a - b)
  const horizontalSteps = horizontals[1] - horizontals[0]
  const verticalSteps = verticals[1] - verticals[0]
  
  return verticalSteps + horizontalSteps
}

const calculateDistances = (coords) => {
  let steps = 0
  
  for (let i = 0; i < coords.length; i++) {
    for (let j = i + 1; j < coords.length; j++) {
      steps += findShortestDistance(coords[i], coords[j])
    }
  }
  
  return steps
}
const mapRows = parsedInput('input.txt')
const mapCols = inputColumns(mapRows)

const allDotRowsIndexes = allDotsIndexes(mapRows)
const allDotColsIndexes = allDotsIndexes(mapCols)

const coordinates = galaxiesCoords(mapRows)
const expandedCoordinates = mapCoordsWithExpansion(coordinates, allDotRowsIndexes, allDotColsIndexes)
console.log(calculateDistances(expandedCoordinates))

