def transform_data(data)
  data[0].split(/,/).map(&:to_i)
end

def spawn_days(start_day, max_day)
  days = []
  return days if start_day > max_day

  day = start_day
  while day < max_day
    days << day + 9
    day += 7
  end

  days
end


def part_one(data)
  fish = data.map { |f| f }
  fish_count = fish.length
  max_days = 80

  while true
    days = []
    fish.each do |f|
      days.concat spawn_days(f, max_days)
    end

    break if days.length == 0
    fish = days.map { |f| f + 8 }
    fish_count += days.length
  end

  puts fish_count

end


def part_two(data)

  temp_buckets = [0, 0, 0, 0, 0, 0, 0]
  buckets = [0, 0, 0, 0, 0, 0, 0]
  data.each { |d| buckets[d - 1] += 1 }

  day = 0

  while day < 256
    day += 1

    from_day = (day - 2) % 7
    to_day = (day) % 7
    bday = (day - 1) % 7

    # puts "from #{from_day}, to #{to_day}"

    buckets[to_day] += temp_buckets[bday]
    temp_buckets[bday] = buckets[from_day]
    # puts "#{day}  #{buckets.inspect}  #{temp_buckets.inspect} #{buckets.sum}"
  end

  total_fish = buckets.sum + temp_buckets.sum
  puts "Total fish #{total_fish}"

  # end_time = Time.now

  # puts "Fish count #{fish_count}"
  # puts " %0.2f ms" % ((end_time - begin_time) * 1000)
end
