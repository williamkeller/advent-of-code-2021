
def transform_data(data)
  octos = Hash.new { -1 }
  data.each_with_index do |row, i|
    row.chars.each_with_index do |col, j|
      octos[[i, j]] = col.to_i
    end
  end

  octos
end


def flash(data, x, y, depth = 0)
  raise 'unexpected flash' if data[[x, y]] <= 9
  return if data[[x, y]] == 20

  data[[x, y]] = 20

  neighbors = [
    [x - 1, y + 1], [x, y + 1], [x + 1, y + 1],
    [x - 1, y],                 [x + 1, y],
    [x - 1, y - 1], [x, y - 1], [x + 1, y - 1]
  ]

  neighbors.each do |nx, ny|
    next if data[[nx, ny]] == -1 # out of bounds
    next if data[[nx, ny]] == 20 # already flashed

    newvalue = (data[[nx, ny]] += 1)
    if newvalue > 9
      flash(data, nx, ny, depth + 1)
    end
  end
end


def part_one(data)
  total_flashes = 0

  (1..100).each do |step|

    # Update everyone
    data.transform_values! { |value| value + 1 }

    # Recursivelly look for flashes
    data.each_pair { |key, value| flash(data, key[0], key[1]) if value > 9 }

    # Count the flashes
    flashes = data.values.count { |v| v > 9 }
    total_flashes += flashes

    # Reset the flashed
    data.transform_values! { |value| value == 20 ? 0 : value }
  end

  puts total_flashes
end


def part_two(data)
  total_flashes = 0

  (1..2000).each do |step|

    # Update everyone
    data.transform_values! { |value| value + 1 }

    # Recursivelly look for flashes
    data.each_pair { |key, value| flash(data, key[0], key[1]) if value > 9 }

    # Count the flashes
    flashes = data.values.count { |v| v > 9 }
    if flashes == 100
      puts "synchronized on step #{step}"
      break
    end
    total_flashes += flashes

    # Reset the flashed
    data.transform_values! { |value| value == 20 ? 0 : value }
  end
end
