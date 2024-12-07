require 'pry'

def input(file)
  File.open(file).readlines.map(&:chomp)
end

def parse(input)
  input.map do |line|
    total, equation = line.split(": ")
    [total.to_i, equation.split(" ").map(&:to_i)]
  end
end

def get_total(digits, operators)
  total = digits.first
  for i in 0...operators.length do
    if operators[i] == "||"
      total = (total.to_s + digits[i+1].to_s).to_i 
    else
      total = total.send(operators[i].to_sym, digits[i+1])
    end
  end
  total
end

def correct_result_sum(parsed_input)
  operators = ["+", "*", "||"]
  sum = 0

  parsed_input.each do |(total, nums)|
    operator_permutations = operators.repeated_permutation(nums.length - 1)

    operator_permutations.each do |op|
      permuted_total = get_total(nums, op)
      if permuted_total == total
        sum += total
        break
      end
    end
  end

  sum
end

parsed = parse(input("input.txt"))
puts correct_result_sum(parsed) # took long!