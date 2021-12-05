def parse_line(line)
  match = line.match /(\d+),(\d+) \-> (\d+),(\d+)/

  raise 'Regular expression didn\'t match' if match.nil?

  { x1: match[1].to_i, y1: match[2].to_i,
    x2: match[3].to_i, y2: match[4].to_i }
end


def generate_cells(vent)
  xrun = nil
  yrun = nil

  # Horizontal run
  if vent[:x1] == vent[:x2]
    xrun = Array.new((vent[:y1] - vent[:y2]).abs + 1, vent[:x1])
    yrun = (vent[:y1] < vent[:y2]) ? (vent[:y1]..vent[:y2]).to_a :
      (vent[:y2]..vent[:y1]).to_a.reverse

  # Vertical run
  elsif vent[:y1] == vent[:y2]

    xrun = (vent[:x1] < vent[:x2]) ? (vent[:x1]..vent[:x2]).to_a :
      (vent[:x2]..vent[:x1]).to_a.reverse
    yrun = Array.new((vent[:x1] - vent[:x2]).abs + 1, vent[:y1])

  # Diagonal run
  elsif (vent[:x1] - vent[:x2]).abs == (vent[:y1] - vent[:y2]).abs
    xrun = (vent[:x1] < vent[:x2]) ? (vent[:x1]..vent[:x2]).to_a :
      (vent[:x2]..vent[:x1]).to_a.reverse
    yrun = (vent[:y1] < vent[:y2]) ? (vent[:y1]..vent[:y2]).to_a :
      (vent[:y2]..vent[:y1]).to_a.reverse
  end

  xrun.zip(yrun)
end


def count_intersections(cells)
  counts = Hash.new { 0 }
  cells.each do |cell|
    counts[cell] += 1
  end

  total = counts.values.count { |cell| cell > 1 }
  puts total
end


def part_one(data)
  vents  = data.map { |d| parse_line d }
    .filter { |d| d[:x1] == d[:x2] || d[:y1] == d[:y2] }

  cells = vents.map { |vent| generate_cells(vent) }.flatten(1)
  count_intersections cells
end


def part_two(data)
  vents  = data.map { |d| parse_line d }

  cells = vents.map { |vent| generate_cells(vent) }.flatten(1)
  count_intersections cells
end
