require 'pry'

def input(file)
  File.open(file).readlines.map(&:chomp)
end

def is_xmas?(center_coordinate, matrix)
  x, y = center_coordinate

  return if y-1 < 0 || x-1 < 0 || x+1 >= matrix.first.length || y+1 >= matrix.length

  ltr_diagonal = [matrix[y-1][x-1], matrix[y][x], matrix[y+1][x+1]]
  rtl_diagonal = [matrix[y-1][x+1], matrix[y][x], matrix[y+1][x-1]]

  ltr_string_is_xmas_or_samx = ["MAS", "SAM"].include?(ltr_diagonal.join)
  rtl_string_is_xmas_or_samx = ["MAS", "SAM"].include?(rtl_diagonal.join)

  ltr_string_is_xmas_or_samx && rtl_string_is_xmas_or_samx
end

def xmas_count(matrix)
  count = 0

  matrix.each_with_index do |string, y|
    for i in 0...string.length do
      current_coord = [i, y]

      count += 1 if is_xmas?(current_coord, matrix)
    end
  end

  count
end

parsed_file = input("input.txt")
puts xmas_count(parsed_file)
