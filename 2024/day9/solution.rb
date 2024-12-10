require 'pry'

def diskmap
  File.open('test-input.txt').readlines.first
end

def blocks(diskmap)
  diskmap.split('').select.with_index {|_, i| i % 2 == 0}.map(&:to_i)
end

def spaces(diskmap)
  diskmap.split('').select.with_index {|_, i| i % 2 == 1}.map(&:to_i)
end

def full_map(blocks, spaces)
  map = []

  blocks.each_with_index do |b, i|
    map += [i.to_s] * b
    next if spaces[i].nil?
    map += ['.'] * spaces[i]
  end

  map
end

def move_block(full_map)
  front_pointer = 0
  back_pointer = full_map.length - 1

  while front_pointer <= back_pointer
    front_pointer += 1 and next if full_map[front_pointer] != "."
    back_pointer -= 1 and next if full_map[back_pointer] == "."

    full_map[front_pointer] = full_map[back_pointer]
    full_map[back_pointer] = "."
    back_pointer -= 1
    front_pointer += 1
  end

  full_map
end

def count_checksum(moved_map)
  moved_map.delete('.')
  sum = 0
  for i in 0...moved_map.length do
    sum += i * moved_map[i].to_i
  end

  sum
end

blks = blocks(diskmap)
fm = full_map(blks, spaces(diskmap))
moved_map = move_block(fm)
# puts moved_map.inspect
puts count_checksum(moved_map)