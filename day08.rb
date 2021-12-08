def transform_data(data)

  data.map do |line|
    src, result = line.split(/\|/)
    [
      src.split.map(&:strip),
      result.split.map(&:strip),
    ]
  end
end


def part_one(data)
  count = 0
  data.each do |line|
    src = line[0].sort { |a, b| a.length <=> b.length }
    result = line[1].map { |d| d.chars.sort.join }

    num = [10]

    num[1] = src[0].chars.sort.join
    num[4] = src[2].chars.sort.join
    num[7] = src[1].chars.sort.join
    num[8] = src[9].chars.sort.join

    fives = src.filter { |num| num.length == 5 }.map { |f| f.chars.sort.join }
    num[3] =  fives.filter { |n| (n.chars - num[1].chars).length == 3 }[0].chars.sort.join
    num[2] = fives.filter { |f| (f.chars - num[3].chars - num[4].chars).length == 1 }[0].chars.sort.join
    num[5] = fives.filter { |f| f != num[2] && f != num[3] }[0]

    sixes = src.filter { |num| num.length == 6 }.map { |s| s.chars.sort.join }
    num[9] = sixes.filter { |s| (s.chars - num[3].chars).length == 1 }[0]
    num[6] = sixes.filter { |s| s.chars != num[9].chars && (s.chars - num[7].chars).length == 4 }[0]
    num[0] = sixes.filter { |s| s.chars != num[9].chars && s.chars != num[6].chars }[0]

    result.each do |res|
      digit = num.find_index(res)
      if digit == 1 || digit == 4 || digit == 7 || digit == 8
        count +=1
      end
    end
  end

  puts "count = #{count}"
end


def part_two(data)
  count = 0

  data.each do |line|
    src = line[0].sort { |a, b| a.length <=> b.length }
    result = line[1].map { |d| d.chars.sort.join }

    num = [10]

    num[1] = src[0].chars.sort.join
    num[4] = src[2].chars.sort.join
    num[7] = src[1].chars.sort.join
    num[8] = src[9].chars.sort.join

    fives = src.filter { |num| num.length == 5 }.map { |f| f.chars.sort.join }
    num[3] =  fives.filter { |n| (n.chars - num[1].chars).length == 3 }[0].chars.sort.join
    num[2] = fives.filter { |f| (f.chars - num[3].chars - num[4].chars).length == 1 }[0].chars.sort.join
    num[5] = fives.filter { |f| f != num[2] && f != num[3] }[0]

    sixes = src.filter { |num| num.length == 6 }.map { |s| s.chars.sort.join }
    num[9] = sixes.filter { |s| (s.chars - num[3].chars).length == 1 }[0]
    num[6] = sixes.filter { |s| s.chars != num[9].chars && (s.chars - num[7].chars).length == 4 }[0]
    num[0] = sixes.filter { |s| s.chars != num[9].chars && s.chars != num[6].chars }[0]

    nums = []
    result.each do |res|
      nums << num.find_index(res)
    end
    count += nums.join.to_i
  end

  puts "count = #{count}"
end
