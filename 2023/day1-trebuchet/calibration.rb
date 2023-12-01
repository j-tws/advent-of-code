# require 'pry'

class Calibrate
  def initialize(input_file)
    file = File.open(input_file)
    @lines = file.readlines.map(&:chomp)
  end

  def values
    @lines.map do |line|
      digits = line.scan(/\d/)
      (digits.first + digits.last).to_i
    end.sum
  end

  # part 2
  def letter_values
    number_map = {
      'one' => '1',
      'two' => '2',
      'three' => '3',
      'four' => '4',
      'five' => '5',
      'six' => '6',
      'seven' => '7',
      'eight' => '8',
      'nine' => '9',
    }

    # the ?= means positive lookahead in regex
    # it allows you to match portions of a string based on a pattern that comes immediately after it in the full string 
    # in other words, it tests the regex in every step it takes.
    pattern = /(?=(#{number_map.keys.join('|')}|\d))/
    
    @lines.each_with_index.map do |line, index|
      digits = line.scan(pattern).flatten
      first_digit = number_map.keys.include?(digits.first) ? number_map[digits.first] : digits.first
      second_digit = number_map.keys.include?(digits.last) ? number_map[digits.last] : digits.last
      (first_digit + second_digit).to_i
    end.sum
  end
end

puts Calibrate.new('input.txt').values
puts Calibrate.new('input.txt').letter_values
