class Board

	def intialize
		@board = Array.new(6){Array.new(7,"0")}
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

  def printCoords #grid layout
    puts " COL  1   2   3   4   5   6   7 ",
         "row1:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
         "--------------------------------",
         "row2:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
         "--------------------------------",
         "row3:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
         "--------------------------------",
         "row4:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
         "--------------------------------",
         "row5:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
         "--------------------------------",
         "row6:(1)|(2)|(3)|(4)|(5)|(6)|(7)"
  end

  #move mechanics
  def inside_board(row, col) #true as long as @col_num has a value between 0 and 6 aka will be in element 1 thru 7 on any row
    0 <= col && col <= 6
    0 <= row && row <= 5
  end
  
  def first_empty_row
	  ((row + 1)..5).each do |row_num| 
		  if @board[row_num][col] == " "
			  print "You can't skip an empty row boi"
			  break
			  return false
			end
		end
	end

  def valid_drop(row, col)
  	return true if @board[row][col] == " " && (inside_board and first_empty_row) 	
  end

  def drop_piece(piece, row, col)
    @board[row][col] = piece if valid_drop #put piece down in this spot
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
