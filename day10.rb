
SYMBOLS = [
  # open, close, wrong, missing
  ['[', ']', 57, 2],
  ['(', ')', 3, 1],
  ['<', '>', 25137, 4],
  ['{', '}', 1197, 3]
]


def check_statement(line)
  stack = []
  err = 0

  line.chars.each do |c|

    if ['[', '<', '{', '('].include? c
      stack.push c

    else
      sym = SYMBOLS.find { |s| s[1] == c }
      if stack.pop != sym[0]
        err = sym[2]
      end
    end
  end

  [err, stack.reverse]
end


def score_remaining(remaining)
  total_score = 0

  remaining.each do |c|
    sym = SYMBOLS.find { |s| s[0] == c }
    total_score = total_score * 5 + sym[3]
  end

  total_score
end


def part_one(data)
  total = 0
  data.each do |line|
    err, remaining = check_statement line
    total += err
  end
  puts total
end


def part_two(data)
  scores = []
  data.each do |line|
    err, remaining = check_statement line

    if err == 0 && remaining.length > 0
      scores << score_remaining(remaining)
    end
  end

  len = scores.length
  puts scores.sort[len / 2]
end
