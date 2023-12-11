require 'pry'

class Maze
  attr_reader :tile

  DIRECTION = {
    north: [-1, 0],
    south: [1, 0],
    east: [0, 1],
    west: [0, -1]
  }

  def initialize(input_file)
    file = File.open(input_file)
    @tile = file.readlines.map do |line|
      line.chomp.split('')
    end
  end

  def s_location
    @tile.each_with_index do |x, row|
      x.each_with_index do |y, col|
        if y == 'S'
          return [row, col]
        end
      end
    end
  end

  def start_points
    row, col = s_location
    @north_start = [row - 1, col]
    @south_start = [row + 1, col]
    @east_start = [row, col + 1]
    @west_start = [row, col - 1]
  end

  def make_loop(start_point, start_direction)
    current_direction = start_direction
    row, col = start_point
    return 'no loop - hit the wall' if row < 0 || col < 0

    current_point = @tile[row][col]
    round_loop = []
    coordinates = [[row, col]]
    
    while current_point != 'S'
      if current_point == 'F'
        current_direction == :north ? current_direction = :east : current_direction = :south
      elsif current_point == '7'
        current_direction == :east ? current_direction = :south : current_direction = :west
      elsif current_point == 'J'
        current_direction == :south ? current_direction = :west : current_direction = :north
      elsif current_point == 'L'
        current_direction == :west ? current_direction = :north : current_direction = :east
      elsif current_point == '.'
        return 'no loop found'
      end

      move_row, move_col = DIRECTION[current_direction]
      row, col = [row + move_row, col + move_col]
      current_point = @tile[row][col]
      round_loop << current_point
      coordinates << [row, col]
      # @tile[row][col] = '^'
    end

    {loop: round_loop, coordinates: coordinates}
  end

  def east_loop
    make_loop(@east_start, :east)
  end

  def west_loop
    make_loop(@west_start, :west)
  end
  
  def north_loop
    make_loop(@north_start, :north)
  end
  
  def south_loop
    make_loop(@south_start, :south)
  end

  def find_max_steps
    [
      (north_loop[:loop].length + 1) / 2,
      (south_loop[:loop].length + 1) / 2,
      (east_loop[:loop].length + 1) / 2,
      (west_loop[:loop].length + 1) / 2,
    ]
  end

  def tiles_in_loop
    inside_tile = false
    inside_tile_count = 0
    loop_coords = south_loop[:coordinates]
    turn = 'F'
    
    @tile.each_with_index do |x, row|
      x.each_with_index do |y, col|
        current_coordinates = [row, col]
        # need to check if current is outside of loop
        current_loop_row = loop_coords.select {|coord| coord[0] == row}.sort
        
        if !current_loop_row.empty?
          if col < current_loop_row.first.last || col > current_loop_row.last.last
            inside_tile = false
            next
          end
        end

        if loop_coords.include?(current_coordinates)
          # puts "current: #{y}, inside? : #{inside_tile}"
          if y == 'S'
            inside_tile = !inside_tile
            next
          end

          if y == 'F' || y == 'L'
            turn = y
            inside_tile = !inside_tile
            next
          end

          if turn == 'F'
            if y == '7'
              inside_tile = !inside_tile
            elsif y == '|'
              inside_tile = !inside_tile
            end
          elsif turn == 'L'
            if y == 'J'
              inside_tile = !inside_tile
            elsif y == '|'
              inside_tile = !inside_tile
            end
          end
        elsif inside_tile
          # puts "#{y}, coords: #{[row, col]}"
          inside_tile_count += 1
        end
      end
    end
    inside_tile_count
  end
end

m = Maze.new('input.txt')
m.start_points
# puts m.find_max_steps
puts m.tiles_in_loop