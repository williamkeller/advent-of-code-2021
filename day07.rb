MAX_FUEL = 9999999999


def transform_data(data)
  data[0].split(/,/).map(&:to_i)
end


def fuel_cost(dist)
  cost = 0

  for i in 1..dist
    cost += i
  end

  cost
end


def part_one(data)
  positions = data.sort

  last_fuel = MAX_FUEL
  for i in 0..(positions.length)
    total_fuel = 0
    positions.each do |pos|
      total_fuel += (pos - i).abs
    end

    if total_fuel < last_fuel
      last_fuel = total_fuel
    else
      break
    end
  end

  puts last_fuel
end


def part_two(data)
  positions = data.sort

  last_fuel = MAX_FUEL
  for i in 0..(positions.length)
    total_fuel = 0
    positions.each do |pos|
      total_fuel += fuel_cost((pos - i).abs)
    end

    if total_fuel < last_fuel
      last_fuel = total_fuel
    else
      break
    end
  end

  puts last_fuel
end
