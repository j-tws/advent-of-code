require 'pry'

def input
  File.open("input.txt").readlines.map(&:chomp)
end

matrix = input.dup

DIRECTIONS = [:up, :down, :left, :right]
MAX_X = matrix.first.length - 1
MAX_Y = matrix.last.length - 1

Coords = Struct.new(:x, :y) do
  def out_of_bounds?
    x.negative? || y.negative? || x > MAX_X || y > MAX_Y
  end
end

def get_starts(matrix)
  heads = []

  matrix.each_with_index do |row, row_index|
    for col_index in 0...row.length do
      heads << Coords.new(col_index.to_i, row_index.to_i) if row[col_index].to_i.zero?
    end
  end

  heads
end

def move(coords, direction)
  x, y = [coords.x, coords.y]
  case direction
  when :up
    Coords.new(x, y - 1)
  when :right
    Coords.new(x + 1, y)
  when :down
    Coords.new(x, y + 1)
  when :left
    Coords.new(x - 1, y)
  end
end

def find_trails(coords, trails)
  current = input[coords.y][coords.x].to_i

  if current == 9
    trails << coords
    return
  end

  DIRECTIONS.each do |direction|
    next_coord = move(coords, direction)
    next if next_coord.out_of_bounds?

    next_el = input[next_coord.y][next_coord.x].to_i

    next if next_el - current != 1

    find_trails(next_coord, trails)
  end

  # trails.uniq # solution 1
  trails # solution 2
end



starts = get_starts(input)
total_trails = []
starts.each do |start|
  total_trails << find_trails(start, [])
end

puts total_trails.sum {|trail| trail.length}
