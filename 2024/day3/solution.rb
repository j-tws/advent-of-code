require 'pry'



def parse(file)
  File.open(file).readlines
end

def get_multiples(string)
  multiples = string.scan /mul\(\d{1,3},\d{1,3}\)/
  int_values = multiples.map {|m| m.split(/mul\(|,|\)/).drop(1).map(&:to_i)}
  int_values.map {|num| num.first * num.last}.sum
end

def get_multiples_with_instruction(string)
  multiples = string.scan /mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/
  removed_dos_and_dont = remove_multiples(multiples)
  int_values = removed_dos_and_dont.map {|m| m.split(/mul\(|,|\)/).drop(1).map(&:to_i)}
  int_values.map {|num| num.first * num.last}.sum
end

def remove_multiples(array)
  new_multiples = []
  inside_dont = false

  array.each do |el|
    inside_dont = true if el == "don't()" && !inside_dont
    inside_dont = false if el == "do()" && inside_dont

    new_multiples << el if !inside_dont
  end

  new_multiples.delete("do()")
  new_multiples
end


puts parse('input.txt').map {|str| get_multiples(str)}.sum # solution 1
puts parse('input.txt').map {|str| get_multiples_with_instruction(str)}.sum # solution 2