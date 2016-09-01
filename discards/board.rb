load 'player.rb'
class Board
  def initialize
    @board = Array.new(6) { Array.new(7, " ") }
    @row = 0
  end
 
  def printCoords #prints game grid showing how columns and rows are numbered
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

  def printboard #prints from elements of @board which are separated by | and ---
    (0..5).each do |row|
      (0..6).each do |col|
        print @board[row][col]
        print "|" unless col == 6
        print "\n" if col == 6
      end
      print "-------------\n" unless row == 5
    end
  end


def prompt_move(current_player)
  puts " #{current_player}'s turn. Choose a column!",
  col_num = (gets.chomp.to_i - 1)
  @col_num = col_num
end

#move mechanics
  def inside_board #true as long as @col_num has a value between 0 and 6 aka will be in element 1 thru 7 on any row
    0 <= @col_num && @col_num <= 6
  end

  def has_room #true as long as any element in the entire column @col_num has value of " "
    (0..5).any? do |row|
  	  @board[row][@col_num] == " "
    end
  end

  def valid_move #not a valid move unless both are true.
    return false unless (inside_board == true) and (has_room == true)
  end

  def drop_piece
    (0..5).each do |row_num| #iterate through each row
      next unless @board[-1 - row_num][@col_num] == " " #skip to the next iteration/row unless the spot is empty (has value "0")
      @row = row_num #set row var to this row because this is where the piece is placed
      break #break out of block
    end
    @board[-1 - @row][@col_num] = @piece if valid_move #put piece down in this spot
  end

  def testboard
    puts @piece
    puts @current_player
    puts @board[3][4]
    puts @board[2]
    @board[0][2] = "0"
    @board[2][2] = "2"
    @board[5][2] = "X"
    @col_num = 3
    drop_piece
    @board[-1][3] = @piece
    @board[-1][4] = @piece
    puts @board[3][2]

  end

#win conditions:
  #straight wins
  def straight_check_col
    in_a_col_counter = 0
    row_up_iterater = 4
    row_down_iterater = 6

    2.times do #check for wins in that column
      if (0 <= (row_up_iterater - @row) && (row_up_iterater - @row) <= 5) and @piece == @board[(row_up_iterater - @row)][@col_num] #checks up that column
        row_up_iterater -= 1
        in_a_col_counter += 1
      end
      if (0 <= (row_down_iterater - @row) && (row_down_iterater - @row) <= 5) and @piece == @board[(row_down_iterater - @row)][@col_num] #checks down that column
        row_down_iterater += 1
        in_a_col_counter += 1
      end
      break if in_a_col_counter == 3 #if there's 
      if in_a_col_counter == 3 
        puts "#{@player_name} is the winner!"
        return true
      end
    end
  end
  
  def straight_check_row
    in_a_row_counter = 0
    col_left_iterater = 1
    col_right_iterater = 1
    2.times do #check for wins in that row
      if (0 <= (@col_num + col_right_iterater) && (@col_num + col_right_iterater) <= 6) and @piece == @board[(5 - @row)][@col_num + col_right_iterater]
        col_right_iterater += 1
        in_a_row_counter += 1
      end
      if (0 <= (@col_num - col_left_iterater) && (@col_num - col_left_iterater) <= 6) and @piece == @board[(5 - @row)][@col_num - col_left_iterater]
        col_left_iterater += 1
        in_a_row_counter += 1
      end
      break if in_a_row_counter == 3
      if in_a_row_counter == 3 
        puts "#{@player_name} is the winner!"
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
      if (0 <= (@col_num + col_right_iterater) && (@col_num + col_right_iterater) <= 6) and (0 <= (row_up_iterater - @row) && (row_up_iterater - @row) <= 5) and @piece == @board[row_up_iterater - @row][@col_num + col_right_iterater]
        col_right_iterater += 1
        row_up_iterater -= 1
        fwd_diag_counter += 1
      end
      if (0 <= (@col_num - col_left_iterater) && (@col_num - col_left_iterater) <= 6) and (0 <= (row_down_iterater - @row) && (row_down_iterater - @row) <= 5) and @piece == @board[row_down_iterater - @row][@col_num - col_left_iterater]
        col_left_iterater += 1
        row_down_iterater += 1
        fwd_diag_counter += 1
      end
      break if fwd_diag_counter == 3 
      if fwd_diag_counter == 3 
        puts "#{@player_name} is the winner!"
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
      if (0 <= (@col_num + col_right_iterater) && (@col_num + col_right_iterater) <= 6) and (0 <= (row_down_iterater - @row) && (row_down_iterater - @row) <= 5) and @piece == @board[row_down_iterater - @row][@col_num + col_right_iterater]
        col_right_iterater += 1
        row_down_iterater += 1
        bwd_diag_counter += 1
      end
      if (0 <= (@col_num - col_left_iterater) && (@col_num - col_left_iterater) <= 6) and (0 <= (row_up_iterater - @row) && (row_up_iterater - @row) <= 5) and @piece == @board[row_up_iterater - @row][@col_num - col_left_iterater]
        col_left_iterater += 1
        row_up_iterater -= 1
        bwd_diag_counter += 1
      end
      break if bwd_diag_counter == 3 
      if bwd_diag_counter == 3 
        puts "#{@player_name} is the winner!"
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
      puts "#{@player_name} is the winner!" 
      return true
    end
    return false
  end

end




