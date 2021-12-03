
def calculate(data)

  gamma = ''
  epsilon = ''

  len = data[0].length

  for i in 0...len
    on = 0
    off = 0
    data.each do |line|
      if line[i] == '1'
        on += 1
      else
        off += 1
      end
    end

    if on >= off
      gamma[i] = '1'
      epsilon[i] = '0'
    else
      gamma[i] = '0'
      epsilon[i] = '1'
    end
  end

  [gamma, epsilon]
end


def part_one(data)
  gamma, epsilon = calculate(data)
  len = data[0].length

  puts gamma.to_i(2) * epsilon.to_i(2)
end


def part_two(data)
  len = data[0].length

  o2 = data.clone
  gamma, epsilon = calculate(o2)

  for i in 0...len
    gamma, epsilon = calculate(o2)

    o2 = o2.filter do |line|
      line[i] == gamma[i]
    end

    if o2.length == 1
      break
    end
  end

  co2 = data.clone
  gamma, epsilon = calculate(co2)

  for i in 0...len
    gamma, epsilon = calculate(co2)

    co2 = co2.filter do |line|
      line[i] == epsilon[i]
    end

    if co2.length == 1
      break
    end
  end

  puts o2[0].to_i(2) * co2[0].to_i(2)
end
