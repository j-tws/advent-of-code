import { readFileSync } from 'node:fs'

export const getInput = (filePath) => {
  return readFileSync(filePath, { encoding: 'utf-8' })
}

export const sum = (array) => {
  return array.reduce((acc, curr) => curr + acc, 0)
}