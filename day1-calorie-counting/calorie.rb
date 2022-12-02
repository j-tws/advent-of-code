input = File.foreach('input.txt').map {|value| value.split(' ').join()}

testArr = ['1','2','32', "", '4','5', "", '6','4','3', "" , '3', '2', "", '10', '500', "", '3']

def find3largest(array)
  calorie_set = [0, 0, 0]
  current_calorie = 0

  array.each do |val|
    if val == ""
      if current_calorie > calorie_set[0]
        calorie_set.unshift(current_calorie).pop

      elsif current_calorie.between?(calorie_set[1], calorie_set[0])
        calorie_set.insert(2, current_calorie).pop

      elsif current_calorie.between?(calorie_set[2], calorie_set[1])
        calorie_set[2] = current_calorie
      end

      current_calorie = 0
      next
    end

    current_calorie += val.to_i 
  end

  calorie_set.sum
end

p find3largest(input)

