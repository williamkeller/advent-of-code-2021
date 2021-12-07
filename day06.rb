def transform_data(data)
  data[0].split(/,/).map(&:to_i)
end


def grow_fish(data, max_days)
  temp_buckets = [0, 0, 0, 0, 0, 0, 0]
  buckets = [0, 0, 0, 0, 0, 0, 0]
  data.each { |d| buckets[d - 1] += 1 }

  day = 0

  while day < max_days
    day += 1

    from_day = (day - 2) % 7
    to_day = (day) % 7
    bday = (day - 1) % 7

    buckets[to_day] += temp_buckets[bday]
    temp_buckets[bday] = buckets[from_day]
  end

  buckets.sum + temp_buckets.sum
end


def part_one(data)
  total_fish = grow_fish(data, 80)
  puts "Total fish #{total_fish}"
end


def part_two(data)
  total_fish = grow_fish(data, 256)
  puts "Total fish #{total_fish}"
end
