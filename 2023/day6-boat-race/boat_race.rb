class BoatRace
  def initialize(input_file)
    file = File.open(input_file)
    @lines = file.readlines.map(&:chomp)
  end

  def race_info
    info = @lines.map {|line| line.scan(/\d+/).map(&:to_i)}
    info.first.zip(info.last)
  end

  def wins(time, distance)
    count = 0

    time.times do |i|
      time_left = time - i
      distance_travelled = time_left * i
      count += 1 if distance_travelled > distance
    end

    count
  end

  def multiply_wins
    race_info.map { |(time, distance)| wins(time, distance)}.reduce(:*)
  end
end

puts BoatRace.new('input.txt').multiply_wins