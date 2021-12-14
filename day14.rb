

def transform_data(data)
  template = data[0]
  rules = data.slice(2, 10000).map do |rule|
    parts = rule.split(/ \-> /)
    [parts[0], parts[1]]
  end

  [template, rules]
end


def walk(n1, n2, depth, cache_depth, cache, table)

  if depth == cache_depth
    cache_key = [n1, n2].join
    if cache.key? cache_key
      return cache[cache_key]
    end
  end

  ins = table[[n1, n2]]

  h0 = { ins => 1 }

  if depth == 1
    return h0
  end

  h1 = walk(n1, ins, depth - 1, cache_depth, cache, table)
  h2 = walk(ins, n2, depth - 1, cache_depth, cache, table)

  h = h0.merge(h1, h2) { |k, a, b| a + b }

  if depth == cache_depth
    cache_key = [n1, n2].join
    unless cache.key? cache_key
      cache[cache_key] = h
    end
  end

  h
end


# String methoc. Fine for small data, mediocre for real data.
def part_one(data)
  d = data
  pairs = d[1]
  poly = d[0]

  newStr = ''

  10.times do |t|
    puts t
    newStr = ''
    (0..(poly.length - 2)).each do |i|
      n = poly.slice(i, 2)
      pair = pairs.find { |p| p[0] == n }

      newStr += n[0] + pair[1]
    end

    newStr += poly[-1]
    poly = newStr.clone
  end


  puts newStr.length

  h = Hash.new { 0 }
  newStr.chars.each { |c| h[c] = h[c] + 1 }

  x = h.to_a.sort { |a, b| a[1] <=> b[1] }

  puts x.inspect
  puts x[-1][1] - x[0][1]
end


def part_two(data)
  d = data
  pairs = d[1]
  poly = d[0]

  table = {}
  pairs.each do |p|
    table[[p[0][0], p[0][1]]] = p[1]
  end

  steps = 40
  cache_depth = 20
  cache = {}

  counts = Hash.new { 0 }
  d[0].chars.each { |c| counts[c] = counts[c] + 1 }

  (0..(poly.length - 2)).each do |i|
    h = walk(poly[i], poly[i + 1], steps, cache_depth, cache, table)

    counts.merge!(h) { |k, a, b| a + b }
  end

  counts.each_pair { |k, v| puts "#{k} == #{v}" }

  x = counts.to_a.sort { |a, b| a[1] <=> b[1] }
  puts x[-1][1] - x[0][1]
end
