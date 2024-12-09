require 'pry'

def input(file)
  File.open(file).readlines.map(&:chomp)
end

def find_symbols(input)
  input.join.scan(/\w|\d/).uniq
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

def get_antimodes_coordinates(coord1, coord2)
  coord1_to_coord2 = [coord2.first - coord1.first, coord2.last - coord1.last]
  coord2_to_coord1 = [coord1.first - coord2.first, coord1.last - coord2.last]

  coord1_to_coord2_antimode = [coord2.last + coord1_to_coord2.last, coord2.first + coord1_to_coord2.first]
  coord2_to_coord1_antimode = [coord1.last + coord2_to_coord1.last, coord1.first + coord2_to_coord1.first]

  [coord1_to_coord2_antimode, coord2_to_coord1_antimode]
end

def get_antimodes_jump(coord1, coord2)
  coord1_to_coord2 = [coord2.first - coord1.first, coord2.last - coord1.last]
  coord2_to_coord1 = [coord1.first - coord2.first, coord1.last - coord2.last]

  [coord1_to_coord2, coord2_to_coord1]
end

def out_of_bound(coord, max_row, max_col)
  x, y = coord

  return true if x < 0 || x > max_col || y < 0 || y > max_row
end

def draw_antimode(matrix)
  max_row = matrix.length - 1
  max_col = matrix.first.length - 1
  symbols = find_symbols(matrix)
  overlapped_symbols = []
  antimode_sum = 0

  symbols.each do |symbol|
    symbol_coords = get_symbol_coordinates(matrix, symbol)
    symbol_coords_combinations = get_combinations(symbol_coords)
    symbol_coords_combinations.each do |combination|
      first_am_coord, second_am_coord = get_antimodes_coordinates(combination.first, combination.last)

      unless out_of_bound(first_am_coord, max_row, max_col)
        unless overlapped_symbols.include?(first_am_coord)
          antimode_sum += 1
          overlapped_symbols << first_am_coord
        end
      end
      unless out_of_bound(second_am_coord, max_row, max_col)
        unless overlapped_symbols.include?(second_am_coord)
          antimode_sum += 1
          overlapped_symbols << second_am_coord
        end
      end

    end
  end
  antimode_sum
  # [matrix, overlap]
end

parsed = input('input.txt')
# puts draw_antimode(parsed).join.split('').count {|el| el == "#"}
puts draw_antimode(parsed)