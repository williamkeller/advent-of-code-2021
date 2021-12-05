

RE = /(\d+),(\d+) \-> (\d+),(\d+)/

def parse_line(line)
  match = line.match RE

  raise 'Regular expression didn\'t match' if match.nil?

  { x1: match[1].to_i, y1: match[2].to_i,
    x2: match[3].to_i, y2: match[4].to_i }
end

def generate_cells(vent)
  vents = []

  # Horizontal run
  if vent[:x1] == vent[:x2]
    if vent[:y1] < vent[:y2]
      for i in vent[:y1]..vent[:y2]
        vents << [vent[:x1], i]
      end
    else
      for i in vent[:y2]..vent[:y1]
        vents << [vent[:x1], i]
      end
    end
  elsif vent[:y1] == vent[:y2]
    if vent[:x1] < vent[:x2]
      for i in vent[:x1]..vent[:x2]
        vents << [i, vent[:y1]]
      end
    else
      for i in vent[:x2]..vent[:x1]
        vents << [i, vent[:y1]]
      end
    end
  elsif (vent[:x1] - vent[:x2]).abs == (vent[:y1] - vent[:y2]).abs
    puts "*** diagonal ***"
    puts vent.inspect
    x = (vent[:x1] < vent[:x2]) ? (vent[:x1]..vent[:x2]).to_a :
      (vent[:x2]..vent[:x1]).to_a.reverse
    y = (vent[:y1] < vent[:y2]) ? (vent[:y1]..vent[:y2]).to_a :
      (vent[:y2]..vent[:y1]).to_a.reverse

    vents = x.zip(y)
    puts vents.inspect
  end

  vents
end

def part_one(data)
  vents  = data.map { |d| parse_line d }
    .filter { |d| d[:x1] == d[:x2] || d[:y1] == d[:y2] }

  cells = []
  vents.each do |vent|
    cells.concat(generate_cells(vent))
  end

  counts = Hash.new { 0 }
  cells.each do |cell|
    counts[cell] += 1
  end

  total = counts.values.count { |cell| cell > 1 }
  puts total
end

def part_two(data)
  vents  = data.map { |d| parse_line d }

  cells = []
  vents.each do |vent|
    cells.concat(generate_cells(vent))
  end

  counts = Hash.new { 0 }
  cells.each do |cell|
    counts[cell] += 1
  end

  total = counts.values.count { |cell| cell > 1 }
  puts total
end
