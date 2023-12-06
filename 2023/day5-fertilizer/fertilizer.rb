require 'pry'

class Fertilizer
  def initialize(input_file)
    file = File.open(input_file)
    @lines = file.readlines.map(&:chomp)
  end

  def seeds
    @lines.first.scan(/\d+/).map(&:to_i)
  end

  def mappings
    @lines.slice(2, @lines.length).select {|line| !line.match?(/[a-zA-Z]/)}
  end

  def perform_map(seed)
    mapped_value = seed
    mapped = false

    mappings.each do |line|
      if line == ''
        mapped = false
        next
      end

      if !mapped
        destination, source, range = line.scan(/\d+/).map(&:to_i)
        if mapped_value.between?(source, source + range - 1)
          mapped_value = mapped_value - source + destination
          mapped = true
        end
      end
    end

    mapped_value
  end

  def lowest_mapped_value
    seeds.map { |seed| perform_map(seed) }.min
  end
end

puts Fertilizer.new('input.txt').lowest_mapped_value

# some solutions for part 2 https://github.com/Animeshz/AdventOfCode2023/blob/main/day5_b.rb
# https://github.com/glebm/advent-of-code/blob/main/2023/5/part2.rb
