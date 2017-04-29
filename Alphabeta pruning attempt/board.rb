class Board
  def initialize(initial_board = nil)
    @board_state = [["-"] * 6,["-"] * 6,["-"] * 6,["-"] * 6,["-"] * 6,["-"] * 6,["-"] * 6]
    @board_state = initial_board unless initial_board.nil?
  end

  def print
    5.downto(0) do |i|
      0.upto(6) do |j|
        Kernel.print @board_state[j][i]
      end
      Kernel.print "\n"
    end
    puts [1,2,3,4,5,6,7].join
  end

  def board_state
    [@board_state[0].dup, @board_state[1].dup, @board_state[2].dup, @board_state[3].dup,
     @board_state[4].dup, @board_state[5].dup, @board_state[6].dup]
  end

  def available_moves
    (0..6).to_a.select {|n| @board_state[n][5] == '-'}
  end

  def make_move(column, player)
    new_board_state = board_state
    0.upto(6) do |i|
      if new_board_state[column][i] == "-"
        new_board_state[column][i] = player
        break
      end
    end
    Board.new(new_board_state)
  end

  def count(x, y, horiz, vert, player)
    new_x = x
    new_x = x + 1 if horiz == :right
    new_x = x - 1 if horiz == :left
    new_y = y
    new_y = y + 1 if vert == :up
    new_y = y - 1 if vert == :down
    return 0 if new_x < 0 || new_x > 6 || new_y > 5 || new_y < 0 || @board_state[new_x][new_y] != player
    return 1 + count(new_x, new_y, horiz, vert, player)
  end

  def winner
    0.upto(6) do |x|
      0.upto(5) do |y|
        player = @board_state[x][y]
        next if player == "-"
        left_count = count(x, y, :left, :none, player)
        right_count = count(x, y, :right, :none, player)
        up_count = count(x, y, :none, :up, player)
        down_count = count(x, y, :none, :down, player)
        up_left_count = count(x, y, :left, :up, player)
        down_right_count = count(x, y, :right, :down, player)
        up_right_count = count(x, y, :right, :up, player)
        down_left_count = count(x, y, :left, :down, player)
        best_count = [left_count + right_count + 1, up_count + down_count + 1,
                      up_left_count + down_right_count + 1, up_right_count + down_left_count + 1].max
        if best_count >= 4
          return player
        end
      end
    end
    return nil
  end
end