
def data
  $DATA ||= File.readlines('data/day01.txt').map(&:to_i)
end

def part_one
  inc_count = 0

  for i in 1...data.size
    inc_count += 1 if data[i] > data[i - 1]
  end

  puts "Incremented #{inc_count} times"

end

def part_two
  lines = data

  sums = []

  for i in 2...data.size
    sums << data[i] + data[i - 1] + data[i - 2]
  end

  inc_count = 0

  for i in 1...sums.size
    inc_count += 1 if sums[i] > sums[i - 1]
  end

  puts "Incremented #{inc_count} times"
end

part_one
part_two
