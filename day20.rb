require 'set'

def transform_data(data)
  algorithm = data[0]

  image = data.slice(2, 1000).each do |line|
    line.chars
  end

  [ algorithm, image ]
end


def to_set(array2d)
  maxx = array2d[0].size
  maxy = array2d.size

  set = Set.new { 0 }

  array2d.each_with_index do |row, y|
    row.chars.each_with_index do |c, x|
      set << [x, y] if c == '#'
    end
  end

  set
end


def prune(image, bounds)
  image.keep_if do |cell|
    cell[0] >= bounds[0] &&
    cell[0] <= bounds[1] &&
    cell[1] >= bounds[2] &&
    cell[1] <= bounds[3]
  end
end


def enhance(image, algorithm, min_x, min_y, max_x, max_y)

  new_pixels = Set.new

  (min_x..max_x).each do |x|
    (min_y..max_y).each do |y|
      str = ''

      str += image.include?([x - 1, y - 1]) ? '1' : '0'
      str += image.include?([x,     y - 1]) ? '1' : '0'
      str += image.include?([x + 1, y - 1]) ? '1' : '0'

      str += image.include?([x - 1, y]) ? '1' : '0'
      str += image.include?([x,     y]) ? '1' : '0'
      str += image.include?([x + 1, y]) ? '1' : '0'

      str += image.include?([x - 1, y + 1]) ? '1' : '0'
      str += image.include?([x,     y + 1]) ? '1' : '0'
      str += image.include?([x + 1, y + 1]) ? '1' : '0'

      dec = str.to_i(2)

      if algorithm[dec] == '#'
        new_pixels << [x, y]
      end
    end
  end

  new_pixels
end


def print_image(image)

  b = bounds(image)

  ((b[0])..(b[1])).each do |i|
    ((b[2])..(b[3])).each do |j|
      print image.include?([j, i]) ? '#' : '.'
    end
    puts
  end

  puts
end


def bounds(image, expand = 0)
  b = []

  ary = image.to_a

  x_minmax = ary.minmax { |a, b| a[0] <=> b[0] }
  y_minmax = ary.minmax { |a, b| a[1] <=> b[1] }

  b[0] = x_minmax[0][0] - expand
  b[1] = x_minmax[1][0] + expand
  b[2] = y_minmax[0][1] - expand
  b[3] = y_minmax[1][1] + expand

  b
end


def part_one(data)
  algorithm, image = data
  set = to_set(image)


  b0 = bounds(set)
  b0[0] -= 10
  b0[1] += 10
  b0[2] -= 10
  b0[3] += 10

  b1 = bounds(set)

  # print_image(set)

  2.times do |i|
    b1[0] -= 1
    b1[1] += 1
    b1[2] -= 1
    b1[3] += 1
    processed = enhance(set, algorithm, b0[0], b0[2], b0[1], b0[3])
    # print_image(processed)
    # puts "=== #{processed.size} pixels ==="

    set = processed
  end

  puts "Size before pruning #{set.size}"

  prune(set, b1)

  puts "Size after pruning #{set.size}"

  # print_image(set)
end


def part_two(data)
  algorithm, image = data
  set = to_set(image)


  b0 = bounds(set)
  b0[0] -= 100
  b0[1] += 100
  b0[2] -= 100
  b0[3] += 100

  b1 = bounds(set)

  50.times do |i|
    b1[0] -= 1
    b1[1] += 1
    b1[2] -= 1
    b1[3] += 1
    processed = enhance(set, algorithm, b0[0], b0[2], b0[1], b0[3])

    set = processed
  end

  prune(set, b1)

  puts "Pixels in image #{set.size}"

  print_image(set)
end
