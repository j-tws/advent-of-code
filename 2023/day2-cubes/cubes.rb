require 'pry'

class Cubes
  def initialize(input_file)
    file = File.open(input_file)
    @lines = file.readlines.map(&:chomp)
  end

  def games_info
    @lines.map do |line|
      game_info = {}

      line.split(/:|;/).map { |el| el.split(',') }.each_with_index do |game, index|
        if index == 0
          game_info[:round] = game.first.scan(/\d+/).first.to_i
          next
        end

        game.each do |cubes|
          colour = cubes.match(/green|red|blue/)[0]
          amount = cubes.match(/\d+/)[0]

          game_info[colour] = amount.to_i if !game_info[colour] || game_info[colour] < amount.to_i
        end
      end

      game_info[:power] = game_info['red'] * game_info['blue'] * game_info['green']
      game_info
    end
  end

  def filter_games
    games_info.filter_map do |game|
      game[:round] if game['red'] <= 12 && game['green'] <= 13 && game['blue'] <= 14
    end.sum
  end

  def power
    games_info.map {|h| h[:power]}.sum
  end
end

puts Cubes.new('input.txt').filter_games
puts Cubes.new('input.txt').power
