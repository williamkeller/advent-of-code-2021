def transform_data(data)
  data.map do |row|
    row.chars.map &:to_i
  end
end


def surrounding(map, x, y)
  xmax = map[0].length - 1
  ymax = map.length - 1

  # puts "#{x}, #{y}"
  cur_val = map[y][x]
  neighbors = []

  neighbors << map[y][x - 1] if x > 0
  neighbors << map[y][x + 1] if x < xmax

  neighbors << map[y - 1][x] if y > 0
  neighbors << map[y + 1][x] if y < ymax



  # neighbors << map[y][x - 1] if x > 0 && y >= 0
  # neighbors << map[y - 1][x] if x >= 0 && y > 0

  # neighbors << map[y][x + 1] if x < (map[0].length - 2)
  # neighbors << map[y + 1][x] if y < (map.length - 2)

  # puts "#{cur_val}   #{neighbors.inspect}"
  neighbors.find_index { |n| n <= cur_val }.nil?
end


def part_one(data)
  xmax = data[0].length
  ymax = data.length

  total = 0

  # puts data.inspect
  (0...xmax).each do |x|
    (0...ymax).each do |y|
      if surrounding(data, x, y)
        total += (data[y][x] + 1)
      end
    end
  end

  puts
  puts total

end
