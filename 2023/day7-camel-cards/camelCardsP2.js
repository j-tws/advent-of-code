import { getInput, sum } from "../utils.js"

const parsedInput = (filePath) => {
  return getInput(filePath).split('\n').map(card => {
    const splitted = card.split(' ')
    splitted[1] = parseInt(splitted[1])
    return splitted
  })
}

const cardLabels = 'AKQT98765432J'

const sortFn = (a, b) => {
  for (let i = 0; i < a[0].length; i++) {
    if (cardLabels.indexOf(a[0][i]) > cardLabels.indexOf(b[0][i])){
      return 1
    } else if (cardLabels.indexOf(a[0][i]) < cardLabels.indexOf(b[0][i])){
      return -1
    }
  }
}

const cardRank = (card) => {
  const jAmount = card.split('').filter(el => el === 'J').length
  const others = card.split('').filter(el => el !== 'J')
  const obj = {}

  for (let i = 0; i < others.length; i++) {
    obj[others[i]] ? obj[others[i]]++ : obj[others[i]] = 1
  }

  const sortedObjValues = Object.values(obj).sort((a, b) => b - a)
  sortedObjValues[0] += jAmount

  if (sortedObjValues.length === 1){
    return 'FiveKind'
  } else if (sortedObjValues.includes(4)){
    return 'FourKind'
  } else if (sortedObjValues.includes(3) && sortedObjValues.length === 2){
    return 'FullHouse'
  } else if (sortedObjValues.includes(3) && sortedObjValues.length === 3){
    return 'ThreeKind'
  } else if (!sortedObjValues.includes(3) && sortedObjValues.length === 3){
    return 'TwoPairs'
  } else if (sortedObjValues[0] === 2 && sortedObjValues.length === 4){
    return 'OnePair'
  } else if (sortedObjValues.length === 5) {
    return 'LowestRank'
  }
}

const fiveKinds = (cards) => cards.filter(card => cardRank(card[0]) === 'FiveKind').sort(sortFn)

const fourKinds = (cards) => cards.filter(card => cardRank(card[0]) === 'FourKind').sort(sortFn)

const fullHouses = (cards) => cards.filter(card => cardRank(card[0]) === 'FullHouse').sort(sortFn)

const threeKinds = (cards) => cards.filter(card => cardRank(card[0]) === 'ThreeKind').sort(sortFn)

const twoPairs = (cards) => cards.filter(card => cardRank(card[0]) === 'TwoPairs').sort(sortFn)

const onlyOnePairs = (cards) => cards.filter(card => cardRank(card[0]) === 'OnePair').sort(sortFn)

const lowestRanks = (cards) => cards.filter(card => cardRank(card[0]) === 'LowestRank').sort(sortFn)

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