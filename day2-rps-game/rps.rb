input = File.foreach('input.txt').map {|value| value.split(' ')}

test_arr = [['A', 'Y'], ['B', 'X'], ['C', 'Z']]

def score(array)
  score_play = { 'X' => 0, 'Y' => 3, 'Z' => 6}

  score_table = {
    'A' => { 'X' => 3, 'Y' => 1, 'Z' => 2 },
    'B' => { 'X' => 1, 'Y' => 2, 'Z' => 3 },
    'C' => { 'X' => 2, 'Y' => 3, 'Z' => 1 },
  }

  total = 0

  array.each do |array|
    total += score_play[array[1]] + score_table[array[0]][array[1]]
  end

  total
end

p score(input)

