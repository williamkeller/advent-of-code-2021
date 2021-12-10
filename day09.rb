def transform_data(data)
  cells = Hash.new { 9 }

  data.each_with_index do |line, r|
    values = line.chars.map(&:to_i)
    values.each_with_index do |cell, c|
      cells[[r, c]] = cell
    end
  end

  cells
end


def low_points(cells)
  cells.filter do |key, cell|
    x, y = key

    cells[[x - 1, y]] > cell &&
      cells[[x + 1, y]] > cell &&
      cells[[x, y - 1]] > cell &&
      cells[[x, y + 1]] > cell
  end
end


def spread(cells, x, y)
  cells[[x, y]] = 10 # mark the current cell counted
  count = 1

  neighbors = [[x, y - 1], [x - 1, y], [x, y + 1], [x + 1, y]]

  neighbors.each do |coords|
    if cells[coords] < 9
      count += spread(cells, coords[0], coords[1])
    end
  end

  count
end


def part_one(cells)
  total = low_points(cells).values.sum { |c| c + 1 }
  puts total
end


def part_two(cells)
  points = low_points(cells).keys
  sizes = points.map { |p| spread(cells, p[0], p[1]) }
  total = sizes.sort { |a, b| b <=> a }.first(3).reduce(1) { |v, accum| v * accum }
  puts total
end
