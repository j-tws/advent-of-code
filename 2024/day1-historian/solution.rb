input = File.open('test_input.txt').readlines.map do |line|
  line.chomp.split(' ').map(&:to_i)
end

first_array = input.map(&:first).sort
second_array = input.map(&:last).sort

sum = 0

first_array.each_with_index do |num, index|
  if second_array[index] > num 
    sum += (second_array[index] - num)
  else
    sum += (num - second_array[index])
  end
end

puts sum # first solution

second_sum = 0 # for second solution

first_array.each do |num|
  frequency = second_array.count {|el| el == num}
  second_sum += (num * frequency)
end

puts second_sum # second solution