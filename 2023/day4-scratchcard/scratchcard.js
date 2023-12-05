import { getInput, sum } from "../utils.js"

const parsedInput = (filePath) => {
  const data = getInput(filePath).split('\n')
  const cardInfo = data.map(card => {
    const [cardAndWinningNumbers, myNumbers] = card.split('|')
    const [cardNum, ...winningNumbers] = cardAndWinningNumbers.match(/\d+/g)

    return { cardNum, winningNumbers, myNumbers: myNumbers.match(/\d+/g) }
  })

  return cardInfo
}

const parsedCardInfo = (cardInfo) => {
  const winningNumbers = cardInfo.map(info => info.winningNumbers)
  const myNumbers = cardInfo.map(info => info.myNumbers)

  return { winningNumbers, myNumbers }
}

const processPoints = ({ winningNumbers, myNumbers }) => {
  const winningNumbersAmount = winningNumbers.map( (card, index) => {
    const filteredNums = card.filter(number => myNumbers[index].includes(number))
    return filteredNums.length > 0 ? 2 ** (filteredNums.length - 1) : 0
  })

  return sum(winningNumbersAmount)
}

const processCopies = (cardInfo) => {
  const copies = Array.from(Array(cardInfo.length), () => 1)

  const winningNumbersAmount = cardInfo.map ( ({winningNumbers, myNumbers}) => {
    return winningNumbers.filter( number => myNumbers.includes(number)).length
  })

  winningNumbersAmount.forEach( (wins, index) => {
    for (let i = index + 1; i < wins + 1 + index; i++) {
      copies[i] += copies[index]
    }
  })

  return sum(copies)
}

const cards = parsedInput('input.txt')
const { winningNumbers, myNumbers } = parsedCardInfo(cards)
console.log(processPoints({winningNumbers, myNumbers}))
console.log(processCopies(cards))