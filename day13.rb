require 'set'

def transform_data(data)
  dots = Set.new
  folds = []

  data.each do |line|
    if line =~ /(\d+),(\d+)/
      dots << [$1.to_i, $2.to_i]
    elsif line =~ /fold along ([xy])=(\d+)/
      folds << [$1, $2.to_i]
    end
  end

  [dots, folds]
end


def part_one(data)

  dots, folds = data

  folds.each do |dir, amount|
    if dir == 'y'
      moving = dots.filter { |d| d[1] > amount }

      moving.each do |dot|
        dots << [dot[0], amount - (dot[1] - amount)]
        dots.delete dot
      end

    else
      moving = dots.filter { |d| d[0] > amount }

      moving.each do |dot|
        dots << [amount - (dot[0] - amount), dot[1]]
        dots.delete dot
      end
    end

    break
  end

  puts dots.length
end


def part_two(data)

  dots, folds = data

  folds.each do |dir, amount|
    if dir == 'y'
      moving = dots.filter { |d| d[1] > amount }

      moving.each do |dot|
        dots << [dot[0], amount - (dot[1] - amount)]
        dots.delete dot
      end

    else
      moving = dots.filter { |d| d[0] > amount }

      moving.each do |dot|
        dots << [amount - (dot[0] - amount), dot[1]]
        dots.delete dot
      end
    end
  end

  grid = Array.new(40) { Array.new(40) { ' ' } }

  dots.each do |x, y|
    grid[y][x] = '#'
  end

  grid.each do |row|
    puts row.join
  end
end
