require 'pry'

def diskmap
  File.open('input.txt').readlines.first
end

Block = Struct.new(:value, :frequency) do
  def to_s
    [value.to_i] * frequency
  end
end
Space = Struct.new(:frequency) do
  def to_s
    ['.'] * frequency
  end
end

def blocks(diskmap)
  diskmap
    .split('')
    .select.with_index {|_, i| i % 2 == 0}
    .map.with_index do |b, i|
      Block.new(i, b.to_i)
    end
end

def spaces(diskmap)
  diskmap
    .split('')
    .select.with_index {|_, i| i % 2 == 1}
    .map do |s|
      Space.new(s.to_i)
    end
end

def full_map(blocks, spaces)
  map = []

  blocks.each_with_index do |b, i|
    map << b
    next if spaces[i].nil?
    map << spaces[i]
  end

  map
end

def move_block(full_map, blocks)
  blocks.reverse.each do |block|
    block_index_on_fm = full_map.find_index{|b| b.is_a?(Block) && b.value == block.value}
    available_space = full_map.find.with_index{|el, i| el.is_a?(Space) && block.frequency <= el.frequency && i < block_index_on_fm}

    next if available_space.nil?

    available_space_index = full_map.index(available_space)
    available_space.frequency -= block.frequency
    full_map[block_index_on_fm] = Space.new(frequency: block.frequency)
    full_map.insert(available_space_index, block)
  end

  full_map
end

def count_checksum(moved_map)
  sum = 0
  for i in 0...moved_map.length do
    next if moved_map[i] == "."
    sum += i * moved_map[i].to_i
  end

  sum
end

blks = blocks(diskmap)
spcs = spaces(diskmap)
fm = full_map(blks, spcs)

mb = move_block(fm, blks)
# binding.pry
puts count_checksum(mb.map(&:to_s).flatten)