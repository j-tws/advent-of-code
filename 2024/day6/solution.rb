require 'pry'

UP = "^"
DOWN = "v"
LEFT = "<"
RIGHT = ">"
DIRECTIONS = [UP, DOWN, LEFT, RIGHT]

def input(file)
  File.open(file).readlines.map(&:chomp)
end

def guard_coords(matrix)
  guard_row = matrix.find { |string| string.include?(UP) }
  row = matrix.index(guard_row)
  col = guard_row.split('').index(UP)

  [col, row]
end

def front_coords(current_coord, direction)
  x, y = current_coord

  case direction
  when UP
    [x, y-1]
  when RIGHT
    [x+1, y]
  when DOWN
    [x, y+1]
  when LEFT
    [x-1, y]
  else
    "no such direction"
  end
end

def turn(direction)
  case direction
  when UP
    RIGHT
  when RIGHT
    DOWN
  when DOWN
    LEFT
  when LEFT
    UP
  else
    'no such direction'
  end
end

def move(matrix, current_coord, direction)
  current_x, current_y = current_coord
  new_x, new_y = front_coords(current_coord, direction)

  if matrix[new_y][new_x] == "#"
    new_direction = turn(direction)
    matrix[current_y][current_x] = new_direction
    [matrix, [current_x, current_y], new_direction]
  else
    matrix[current_y][current_x] = "X"
    matrix[new_y][new_x] = direction
  
    [matrix, [new_x, new_y], direction]
  end
end

def getting_out_of_border?(matrix, current_coords, direction)
  max_row = matrix.length - 1
  max_col = matrix.first.length - 1
  col, row = current_coords

  if direction == UP
    row == 0
  elsif direction == RIGHT
    col == max_col
  elsif direction == DOWN
    row == max_row
  elsif direction == LEFT
    col == 0
  else
    nil
  end
end

def traverse(matrix, current_coord, direction)
  new_m, new_c, new_d = move(matrix, current_coord, direction)

  if getting_out_of_border?(new_m, new_c, new_d)
    return new_m
  else
    traverse(new_m, new_c, new_d)
  end
end

matrix = input('input.txt')
starting_coord = guard_coords(matrix)

finish_matrix = traverse(matrix, starting_coord, UP)
puts finish_matrix.join.count("X") + 1