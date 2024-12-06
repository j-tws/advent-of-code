input = File.open('input.txt').readlines.map do |line|
  line.chomp.split(' ').map(&:to_i)
end

safe_count = 0

input.each do |arr|
  safe = true

  next if arr.first == arr.last

  current_arr_order = arr.first <=> arr.last
  ascd_order = current_arr_order == -1
  desc_order = current_arr_order == 1

  arr.each_with_index do |el, i|
    next_el = arr[i+1]
    next if next_el.nil?

    if ascd_order
      safe = false if el > next_el || el == next_el || next_el - el > 3
    end

    if desc_order
      safe = false if el < next_el || el == next_el || el - next_el > 3
    end
  end

  next unless safe

  safe_count += 1
end

puts safe_count # solution 1