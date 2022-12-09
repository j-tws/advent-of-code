# input = File.foreach('testinput.txt').map {|value| value.split("\n").join}
input = File.foreach('input.txt').map {|value| value.split("\n").join}
# input = File.foreach('anothertest.txt').map {|value| value.split("\n").join}

def get_file_size(input)
  current_dir = []
  file_system = {}

  input.each do |command|
    if command.include?("$ cd") && !command.include?("$ cd ..")
      dir = command.gsub("$ cd ", '')
      current_dir << dir
    end

    if command.include?("$ cd ..")
      current_dir.pop
    end

    if command =~ /\d/
      num = command.scan(/\d/).join('')
      filename = command.delete(num).strip
      file_system[current_dir + [filename]] = num.to_i
    end

  end

  # for debugging
  # file_system.each do |key, value|
  #   puts "#{key}: #{value}"
  # end

  puts "================================================================="
  puts "================================================================="
  
  file_system
end

file_system = get_file_size(input)

def get_all_dirs(filesystem)
  directories = {}

  filesystem.keys.each do |file| 
    directories[ file[0..file.length - 2] ] = 0
  end

  directories

end

directories = get_all_dirs(file_system)

class Array
  def count_by
    each_with_object(Hash.new(0)) { |e, h| h[e] += 1 }
  end

  def subset_of?(superset)
    superset_counts = superset.count_by
    count_by.all? { |k, count| superset_counts[k] >= count }
  end
end


def get_dir_size(file_system, directories)
  
  dir_arr = directories.keys
  puts "-------------------------------------------------"

  file_system.each do |directory, size|
    dir_arr.each do |dir|

      if directory.join.include?(dir.join)
        directories[dir] += size
      end
    end

  end

  
  # for debugging
  # directories.each do |key, value|
  #   puts "#{key}: #{value}"
  # end
  
  # p directories.values
  p directories.values.select{|val| val <= 100000 }.sum
end

get_dir_size(file_system, directories)

