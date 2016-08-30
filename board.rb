class Board
  def initialize
    @board = Array.new(6) { Array.new(7, "0") }
    @row = 0
  end

  attr_accessor :row
 
  def printCoords
    puts " COL  1   2   3   4   5   6   7 ",
         "row6:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
         "--------------------------------",
         "row5:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
         "--------------------------------",
         "row4:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
         "--------------------------------",
         "row3:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
         "--------------------------------",
         "row2:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
         "--------------------------------",
         "row1:(1)|(2)|(3)|(4)|(5)|(6)|(7)"
  end

  def printboard
    (0..5).each do |row|
      (0..6).each do |col|
        print @board[-1 - row][col]
        print "|" unless col == 6
        print "\n" if col == 6
      end
      print "-------------\n" unless row == 5
    end
  end

  def inside_board(col_num)
    (0..6) == col_num
  end

  def has_room(col_num)
    (0..5).any? do |row|
  	  @board[-1 - row][col_num] == 0
    end
  end

  def valid_move(col_num)
    inside_board(col_num) and has_room(col_num)
  end

  def drop_piece(col_num)
    (0..5).each do |row|
      @row = 0
      next unless @board[-1 - row][col_num] == 0
      @row = row
      break
    end
    @board[-1 - @row][col_num] = current_player.player_piece
  end


#@row contains the row number that the piece is dropped into and the column number is already known, these will be useful to find whether the surrounding 6 spaces
#vertically/horizontally/diagonally will contain the tiles needed for a win
#win conditions:
  #straight wins
  def straight_check_col
    in_a_col_counter = 0
    row_up_iterater = 4
    row_down_iterater = 6

    2.times do #check for wins in that column
      if (0 <= (row_up_iterater - @row) <= 5) and current_player.player_piece == @board[(row_up_iterater - @row)][col_num]
        row_up_iterater -= 1
        in_a_col_counter += 1
      end
      if (0 <= (row_down_iterater - @row) <= 5) and current_player.player_piece == @board[(row_down_iterater - @row)][col_num]
        row_down_iterater += 1
        in_a_col_counter += 1
      end
      break if in_a_col_counter == 3
      if in_a_col_counter == 3 
        puts "#{current_player} is the winner!"
        return true
      end
    end
  end
  
  def straight_check_row
    in_a_row_counter = 0
    col_left_iterater = 1
    col_right_iterater = 1
    2.times do #check for wins in that row
      if (0 <= (col_num + col_right_iterater) <= 6) and current_player.player_piece == @board[(5 - @row)][col_num + col_right_iterater]
        col_right_iterater += 1
        in_a_row_counter += 1
      end
      if (0 <= (col_num - col_left_iterater) <= 6) and current_player.player_piece == @board[(5 - @row)][col_num - col_left_iterater]
        col_left_iterater += 1
        in_a_row_counter += 1
      end
      break if in_a_row_counter == 3
      if in_a_row_counter == 3 
        puts "#{current_player} is the winner!"
        return true
      end
    end
  end

  #diagonal wins
  def fwd_diag_check
    fwd_diag_counter = 0
    row_up_iterater = 4
    row_down_iterater = 6
    col_left_iterater = 1
    col_right_iterater = 1
    2.times do 
      if (0 <= (col_num + col_right_iterater) <= 6) and (0 <= (row_up_iterater - @row) <= 5) and current_player.player_piece == @board[row_up_iterater - @row][col_num + col_right_iterater]
        col_right_iterater += 1
        row_up_iterater -= 1
        fwd_diag_counter += 1
      end
      if (0 <= (col_num - col_left_iterater) <= 6) and (0 <= (row_down_iterater - @row) <= 5) and current_player.player_piece == @board[row_down_iterater - @row][col_num - col_left_iterater]
        col_left_iterater += 1
        row_down_iterater += 1
        fwd_diag_counter += 1
      end
      break if fwd_diag_counter == 3 
      if fwd_diag_counter == 3 
        puts "#{current_player} is the winner!"
        return true
      end
    end
  end

  def bwd_diag_check
    bwd_diag_counter = 0
    row_up_iterater = 4
    row_down_iterater = 6
    col_left_iterater = 1
    col_right_iterater = 1
    2.times do 
      if (0 <= (col_num + col_right_iterater) <= 6) and (0 <= (row_down_iterater - @row) <= 5) and current_player.player_piece == @board[row_down_iterater - @row][col_num + col_right_iterater]
        col_right_iterater += 1
        row_down_iterater += 1
        bwd_diag_counter += 1
      end
      if (0 <= (col_num - col_left_iterater) <= 6) and (0 <= (row_up_iterater - @row) <= 5) and current_player.player_piece == @board[row_up_iterater - @row][col_num - col_left_iterater]
        col_left_iterater += 1
        row_up_iterater -= 1
        bwd_diag_counter += 1
      end
      break if bwd_diag_counter == 3 
      if bwd_diag_counter == 3 
        puts "#{current_player} is the winner!"
        return true
      end
    end
  end

  #ties
  def ties
    false
    tie_token = 0 #each filled column will increment tie token by 1 and if it reaches 7 it means board is full and game is tied
    (0..6).each do |col_num| has_room(col_num)? break : tie_token += 1
    end
    return true if tie_token == 7
  end

  def win 
    if ties == true 
      puts "Both players have ended the game in a tie"
      return true 
    end
    if (straight_check_row || straight_check_col) || (fwd_diag_check || bwd_diag_check)
      puts "#{current_player} is the winner!" 
      return true
    end
    return false
  end

end




