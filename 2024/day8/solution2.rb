require 'pry'

def input(file)
  File.open(file).readlines.map(&:chomp)
end

def find_symbols(input)
  input.join.scan(/\w|\d/).uniq
end

def symbols_count(input)
  input.join.scan(/\w|\d/).count
end

def get_symbol_coordinates(matrix, symbol)
  coordinates = []

  matrix.each_with_index do |row, row_index|
    for col_index in 0...row.length do
      current_el = row[col_index]

      if current_el == symbol
        coordinates << [row_index, col_index]
      end
    end
  end

  coordinates
end

def get_combinations(coordinates)
  coordinates.repeated_combination(2).to_a.reject {|a| a.first == a.last}
end

def get_antimodes_jump(coord1, coord2)
  coord1_to_coord2 = [coord2.first - coord1.first, coord2.last - coord1.last]
  coord2_to_coord1 = [coord1.first - coord2.first, coord1.last - coord2.last]

  [coord1_to_coord2, coord2_to_coord1]
end

def next_antimode_coord(coord, jump)
  [coord.first + jump.first, coord.last + jump.last]
end

def out_of_bound(coord, max_row, max_col)
  x, y = coord
  x.negative? || x > max_col || y.negative? || y > max_row
end

def draw_antimode(matrix)
  max_row = matrix.length - 1
  max_col = matrix.first.length - 1
  symbols = find_symbols(matrix)

  symbols.each do |symbol|
    symbol_coords = get_symbol_coordinates(matrix, symbol)
    symbol_coords_combinations = get_combinations(symbol_coords)
    symbol_coords_combinations.each do |combination|
      first_jump, second_jump = get_antimodes_jump(combination.first, combination.last)

      next_first_antimode = next_antimode_coord(combination.last, first_jump)
      next_second_antimode = next_antimode_coord(combination.first, second_jump)

      until out_of_bound(next_first_antimode, max_row, max_col)

        current_first_am = matrix[next_first_antimode.first][next_first_antimode.last]
        matrix[next_first_antimode.first][next_first_antimode.last] = "#" if current_first_am == "."
        next_first_antimode = next_antimode_coord(next_first_antimode, first_jump)
      end

      until out_of_bound(next_second_antimode, max_row, max_col)

        current_second_am = matrix[next_second_antimode.first][next_second_antimode.last]
        matrix[next_second_antimode.first][next_second_antimode.last] = "#" if current_second_am == "."
        next_second_antimode = next_antimode_coord(next_second_antimode, second_jump)
      end
    end
  end
  matrix
end

parsed = input('input.txt')
puts draw_antimode(parsed).join.split('').count {|el| el == "#"} + symbols_count(parsed)