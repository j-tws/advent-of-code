import { readFileSync } from 'node:fs'

export const getInput = (filePath) => {
  return readFileSync(filePath, { encoding: 'utf-8' })
}