require 'pry'

def input
  File.open("input.txt").read.split(' ').map(&:to_i)
end

Stone = Struct.new(:num) do
  def even_digits?
    num.to_s.length.even?
  end

  def is_0?
    num.zero?
  end

  def split
    num_s = num.to_s
    [num_s.slice(0...num_s.length / 2).to_i, num_s.slice(num_s.length / 2...num_s.length).to_i]
  end

  def multiply_2024
    self.num = num * 2024
  end
end

sts = input.map {|num| Stone.new(num)}

def blink(stones)
  i = 0

  while i < stones.length do
    current = stones[i]

    if current.is_0?
      current.num = 1
    elsif current.even_digits?
      num_1, num_2 = current.split
      current.num = num_1
      stones.insert(i + 1, Stone.new(num_2))
      i += 1
    else
      current.multiply_2024
    end

    i += 1
  end

  stones
end

75.times do |i|
  puts i
  blink(sts)
  puts sts.map(&:num).inspect
end

puts sts.map(&:num).length.inspect
