require 'pry'

def input(file)
  File.open(file).readlines.join
end

def page_order_rules(input)
  input.scan(/\d+\|\d+/).map {|el| el.split("|").map(&:to_i)} 
end

def page_update(input)
  input.split("\n")
    .grep_v(/\d+\|\d+/)
    .drop(1)
    .map do |numbers|
      numbers.split(',').map(&:to_i)
    end
end

updates = page_update(input('input.txt'))
order_rules = page_order_rules(input('input.txt'))

valid_updates = []

updates.each do |update|
  invalid_update = false
  update.each_with_index do |number, index|
    remaining_numbers = update.slice(index+1..update.length)

    invalid_rule = order_rules.select{|rule| rule.last == number && remaining_numbers.include?(rule.first)}

    if !invalid_rule.empty?
      invalid_update = true
    end
  end

  valid_updates << update if !invalid_update
end

puts valid_updates.map {|update| update[update.length/2]}.sum # solution 1

invalid_updates = (updates - valid_updates)

mapped = invalid_updates.map do |update|
  rules_for_this_update = order_rules.select{|rule| update.include?(rule.last) && update.include?(rule.first)}

  # create a frequency table for each update number on the first part of rule
  hash = {}

  update.each do |num|
    hash[num] = rules_for_this_update.count {|r| r.first == num}
  end

  hash.to_a.sort {|a,b| b.last - a.last}.map{|el| el.first}
end

puts mapped.map {|update| update[update.length/2]}.sum
