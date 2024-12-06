require 'matrix'
require 'pry'

def xmas_count(string)
  string.scan("XMAS").count
end

def samx_count(string)
  string.scan("SAMX").count
end

def input(file)
  File.open(file).readlines.map(&:chomp)
end

def get_verticals(input)
  col_amount = input.first.length
  map = Array.new(col_amount){ "" }

  for i in 0...col_amount do
    current_row = 0

    while current_row < input.length
      map[i] += input[current_row][i]
      current_row += 1
    end
  end

  map
end

def get_ltr_diagonals(input)
  input.reverse.each_with_index.map{|s,i| " " * i + s }.inject(Array.new(input.size + input.last.size-1,"")) do |a,s| 
    puts s.inspect
    s.chars.each_with_index do |c,i| 
      a[i] = c + a[i]
    end
    a
  end.map(&:strip)
end

def get_rtl_diagonals(input)
  input.each_with_index.map{|s,i| " " * i + s }.inject(Array.new(input.size + input.last.size-1,"")) do |a,s| 
    s.chars.each_with_index do |c,i| 
      a[i] = c + a[i]
    end
    a
  end.map(&:strip)
end

def count_xmas(matrix)
  xmas_sum = matrix.map do |string|
    xmas_count(string)
  end.sum

  samx_sum = matrix.map do |string|
    samx_count(string)
  end.sum

  xmas_sum + samx_sum
end

parsed_file = input('input.txt')
print count_xmas(parsed_file) + count_xmas(get_verticals(parsed_file)) + count_xmas(get_rtl_diagonals(parsed_file)) + count_xmas(get_ltr_diagonals(parsed_file))