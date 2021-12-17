RE = /target area: x=(\-?\d+)\.\.(\-?\d+), y=(\-?\d+)..(\-?\d+)/
def transform_data(data)
  data[0].match RE

  { xmin: $1.to_i, xmax: $2.to_i, ymin: $4.to_i, ymax: $3.to_i }
end


def track_probe(vx, vy, bounds)
  x = 0
  y = 0
  max_h = 0

  step = 1

  while true
    x += vx
    y += vy

    max_h = y if vy >= 0

    # puts "%2d: %2d, %2d    %2d, %2d" % [step, x, y, vx, vy]

    raise 'something broke' if step > 3000

    if x >= bounds[:xmin] && x <= bounds[:xmax] &&
       y >= bounds[:ymax] && y <= bounds[:ymin]
      return [ :hit, x, y, max_h ]

    elsif x > bounds[:xmax] || y < bounds[:ymax]
      return [ :overshot ]
    end

    vx -= 1 unless vx == 0
    vy -= 1
    step += 1
  end
end



def part_one(bounds)

  hits = []

  (0..100).each do |i|
    (0..100).each do |j|

      res = track_probe(i, j, bounds)

      if res[0] == :hit
        hits << [i, j, res[3]]
      end

    end
  end

  hits.sort { |a, b| b[2] <=> a[2] }.each do |hit|
    # puts hit.inspect
    puts "%02d %02d    %02d" % [hit[0], hit[1], hit[2]]
  end

  puts "#{hits.length} total hits"
end

def part_two(bounds)

  hits = 0 

  (0..800).each do |i|
    (-100..800).each do |j|

      res = track_probe(i, j, bounds)

      if res[0] == :hit
        hits += 1
      end

    end
  end
  puts "#{hits} total hits"
end
