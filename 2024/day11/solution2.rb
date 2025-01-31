require 'pry'

def input
  File.open("input.txt").read.split(' ')
end

def transform(s)
  if s == "0"
    ["1"]
  elsif s.length.even?
    [s[...s.length / 2], s[s.length / 2..].to_i.to_s]
  else
    [(s.to_i * 2024).to_s]
  end
end

LENGTH_MEMO = {}
def length_after_cycles(stone, cycles)
  return 1 if cycles == 0
  LENGTH_MEMO[[stone, cycles]] ||= (
    transform(stone).sum { |s| length_after_cycles(s, cycles - 1) }
  )
end

puts ["0", "1"].sum {|s| length_after_cycles(s,75)}
puts LENGTH_MEMO
# binding.pry
