def data
  File.open('input.txt').readlines.map do |line|
    line.chomp.split(' ').map(&:to_i)
  end
end

def get_steps(arr)
  steps = []

  arr.each_with_index do |el, i|
    next_el = arr[i+1]
    next if next_el.nil?

    steps << el - next_el
  end

  steps
end

def is_step_safe?(step)
  all_positive = step.all? {|s| s > 0}
  all_negative = step.all? {|s| s < 0}
  compliant_range = step.all? {|s| [1,2,3].include?(s.abs)}

  (all_positive || all_negative) && compliant_range
end

def deleted_element_array(array)
  for i in 0...array.length
    array_copy = *array
    array_copy.delete_at(i)
    new_array_steps = get_steps(array_copy)

    return true if is_step_safe?(new_array_steps)
  end

  false
end

safe_array = 0

data.each do |array|
  steps = get_steps(array)

  if is_step_safe?(steps) || deleted_element_array(array)
    safe_array += 1
  end
end

puts safe_array