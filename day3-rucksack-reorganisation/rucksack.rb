input = File.foreach('input.txt').map {|value| value.split(' ').join}

test_arr = [
  'vJrwpWtwJgWrhcsFMMfFFhFp',
  'jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL',
  'PmmdzqPrVvPwwTWBwg',
  'wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn',
  'ttgJtRGJQctTZtZT',
  'CrZsJsPPZsGzwwsLwLmpwMDw'
]

# Part 1
def score(array)
  priorities = ('a'..'z').to_a.join + ('A'..'Z').to_a.join

  total = 0

  array.each do |string|
    sliced_str = string.slice!(0, string.length / 2)
    letter = sliced_str.split('') & string.split('')
    total += priorities.index(letter.first) + 1
  end

  total
end

# p score(input)

# Part 2
def score_2(array)
  priorities = ('a'..'z').to_a.join + ('A'..'Z').to_a.join

  total = 0

  array.each_slice(3) do |a, b, c|
    letter =  a.split('') & b.split('') & c.split('')
    total += priorities.index(letter.first) + 1
  end

  total
end

p score_2(input)



