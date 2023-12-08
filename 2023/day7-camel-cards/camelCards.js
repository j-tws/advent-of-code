import { getInput, sum } from "../utils.js"

const parsedInput = (filePath) => {
  return getInput(filePath).split('\n').map(card => {
    const splitted = card.split(' ')
    splitted[1] = parseInt(splitted[1])
    return splitted
  })
}

const cardLabels = 'AKQJT98765432'

const sortFn = (a, b) => {
  for (let i = 0; i < a[0].length; i++) {
    if (cardLabels.indexOf(a[0][i]) > cardLabels.indexOf(b[0][i])){
      return 1
    } else if (cardLabels.indexOf(a[0][i]) < cardLabels.indexOf(b[0][i])){
      return -1
    }
  }
}

const cardToObj = (card) => {
  const obj = {}
  for (let i = 0; i < card.length; i++) {
    obj[card[i]] ? obj[card[i]]++ : obj[card[i]] = 1
  }

  return obj
}

const isFiveKind = (card) => [...new Set(card.split(''))].length === 1

const isFourKind = (card) => Object.values(cardToObj(card)).includes(4)

const cardAmount = (card) => Object.values(cardToObj(card))

const isFullHouse = (card) => cardAmount(card).includes(3) && cardAmount(card).length === 2

const isThreeKind = (card) => cardAmount(card).includes(3) && cardAmount(card).length === 3

const isTwoPair = (card) => !cardAmount(card).includes(3) && cardAmount(card).length === 3

const isOnePair = (card) => [...new Set(card.split(''))].length === 4

const isLowestRank = (card) => [...new Set(card.split(''))].length === 5

const fiveKinds = (cards) => cards.filter(card => isFiveKind(card[0])).sort(sortFn)

const fourKinds = (cards) => cards.filter(card => isFourKind(card[0])).sort(sortFn)

const fullHouses = (cards) => cards.filter(card => isFullHouse(card[0])).sort(sortFn)

const threeKinds = (cards) => cards.filter(card => isThreeKind(card[0])).sort(sortFn)

const twoPairs = (cards) => cards.filter(card => isTwoPair(card[0])).sort(sortFn)

const onlyOnePairs = (cards) => cards.filter(card => isOnePair(card[0])).sort(sortFn)

const lowestRanks = (cards) => cards.filter(card => isLowestRank(card[0])).sort(sortFn)

const sortedCards = (cards) => {
  return [...fiveKinds(cards), ...fourKinds(cards), ...fullHouses(cards), ...threeKinds(cards), ...twoPairs(cards), ...onlyOnePairs(cards), ...lowestRanks(cards)].reverse()
}

const bidsSum = (sortedHands) => {
  const bids = sortedHands.map( (hand, index) => hand[1] * (index + 1))
  return sum(bids)
}

const allCards = parsedInput('input.txt')
const sorted = sortedCards(allCards)

console.log(bidsSum(sorted))