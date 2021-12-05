
def evaulate_boardoard(board)
  # Rows
  for i in 0...5
    if board[i][0] == '*' &&
       board[i][1] == '*' &&
       board[i][2] == '*' &&
       board[i][3] == '*' &&
       board[i][4] == '*'
      return true
    end
  end

  # Columns
  for i in 0...5
    if board[0][i] == '*' &&
       board[1][i] == '*' &&
       board[2][i] == '*' &&
       board[3][i] == '*' &&
       board[4][i] == '*'
      return true
    end
  end

  false
end


def mark_board(board, value)
  for i in 0...5
    for j in 0...5
      if board[i][j] == value
        board[i][j] = '*'
      end
    end
  end
end


def score_board(board)
  sum = 0
  for i in 0...5
    for j in 0...5
      sum += board[i][j] unless board[i][j] == '*'
    end
  end

  sum
end

def part_one(data)
  picks = data[0].split(/,/).map(&:to_i)
  boards = []

  index = 1
  while true
    board = []
    for i in 1..5
      board << data[index + i].split.map(&:to_i)
    end
    boards << board
    index += 6
    break if index == data.length
  end

  picks.each do |pick|
    boards.each do |board|
      mark_board(board, pick)
      if evaulate_board(board) == true
        sum = score_board(board)
        puts sum * pick
        return
      end
    end
  end
end

def count_active_boards(boards)
  count = 0
  boards.each do |board|
    count += 1 unless board.nil?
  end
  count
end

def part_two(data)
  picks = data[0].split(/,/).map(&:to_i)
  boards = []

  index = 1
  while true
    board = []
    for i in 1..5
      board << data[index + i].split.map(&:to_i)
    end
    boards << board
    index += 6
    break if index == data.length
  end

  picks.each do |pick|
    boards.each_with_index do |board, i|
      next if board.nil?

      mark_board(board, pick)
      if evaulate_board(board) == true
        if count_active_boards(boards) == 1
          score = score_board(board)
          puts pick, score, score * pick

          return
        else
          boards[i] = nil
        end
      end
    end
  end
end
