class Oasis
  def initialize(input_file)
    file = File.open(input_file)
    @lines = file.readlines.map do |line|
      line.chomp.scan(/\d+|-\d+/).map(&:to_i)
    end
  end

  def predict(array)
    return array if array.all? {|el| el == 0}

    sequence = []
    
    array.each_with_index do |el, index|
      next if index == array.length - 1

      sequence << array[index + 1] - el
    end

    array.push(predict(sequence).last + array.last)
  end

  def predict_p2(array)
    return array if array.all? {|el| el == 0}

    sequence = []
    
    array.each_with_index do |el, index|
      next if index == array.length - 1

      sequence << array[index + 1] - el
    end
    # print array

    array.unshift(array.first - predict_p2(sequence).first)
  end

  def prediction_sum
    @lines.map {|arr| predict(arr).last}.sum
  end

  def prediction_sum_p2
    @lines.map {|arr| predict_p2(arr).first}.sum
  end
end

puts Oasis.new('input.txt').prediction_sum
puts Oasis.new('input.txt').prediction_sum_p2
