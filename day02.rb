
def part_one(data)
  pos = 0
  depth = 0

  data.each do |line|
    cmd, val = line.split(/ /)
    case cmd
    when 'forward'
      pos += val.to_i
    when 'down'
      depth += val.to_i
    when 'up'
      depth -= val.to_i
    else
      raise "unexpected instruction #{line}"
    end
  end

  puts "Total: #{pos * depth}"
end

def part_two(data)
  pos = 0
  depth = 0
  aim = 0

  data.each do |line|
    cmd, val = line.split(/ /)
    case cmd
    when 'forward'
      pos += val.to_i
      depth += (val.to_i * aim)
    when 'down'
      aim += val.to_i
    when 'up'
      aim -= val.to_i
    else
      raise "unexpected instruction #{line}"
    end
  end

  puts "Total: #{pos * depth}"
end
