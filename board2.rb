load 'player.rb'
class Board

	def intialize
		@board = Array.new(6){Array.new(7,"0")}
		@player1 = Player.new("player1", "human", "X")
		@player2 = Player.new("player2", "human", "O")
		@piece = "X"
		@current_player = @players[0]
		@player_name = "filler"
		@row = 4
		@col = 3
	end

	#turn system
	def current_player
		@piece = @current_player.player_piece
		@player_name = @current_player.player_name
	end

	def next_player
		if @current_player == @player1
		  @current_player = @players2
		else
			@current_player = @players1
		end
		@piece = @current_player.player_piece #set new player's piece as "piece"
		@player_name = @current_player.name #ditto for name
	end 

	def get_coords
		puts "#{current_player.name} please enter the row and col number that you want to drop your piece into \n"
		puts "Row: "
		@row = (gets.chomp.to_i) - 1 #user input stored into row
		puts "\n Col: "
		@col = (gets.chomp.to_i) - 1 #user input stored into col
	end

  def print_board #prints from elements of @board which are separated by | and ---
    (0..5).each do |row|
      (0..6).each do |col|
        print @board[row][col]
        print "|" unless col == 6
        print "\n" if col == 6
      end
      print "-------------\n" unless row == 5
    end
  end

  def print_coords #grid layout
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
  
  def first_empty_row(row) #block iterates between the row directly below given row and the bottom of grid
	  ((row + 1)..5).each do |row_num| 
		  if @board[row_num][col] == " " #if any of these rows below the given row coord is empty
			  print "You can't skip an empty row boi" #msg saying so
			  break #breaks block (stops iterating)
			  return false #returns false for first_empty_row
			end
		end#otherwise it'll be true because each returns origin range and that's truthy
	end

  def valid_drop(row, col) #based on given row and col
  	return true if @board[row][col] == " " && (inside_board(row, col) and first_empty_row(row)) 	#valid is empty and also inside grid and has no empty cells below it
  end

  def drop_piece(piece, row, col) 
    if valid_drop == true 
    	@board[row][col] = piece 
    	return true 
    else
    	puts "your row and/or col values are not valid" 
    	return false
    end
  end
  #ternary is mainly for assignments, and can only handle one operation on either side of the : 

  #win conditions:
  #straight wins
  def straight_check_col(piece, row, col)
    in_a_col_counter = 0
    row_up_iterater = 1
    row_down_iterater = 1

    3.times do #check for wins in that column
      if (0 <= (row - row_up_iterater) && (row - row_up_iterater) <= 5) and @board[row][col] == board[row - row_up_iterater][col] #checks up that column
        row_up_iterater += 1 #if that cell is the same then increments the row iterater so next loop will check the one even farther out
        in_a_col_counter += 1 #increments column counter if it is the same
      end
      if (0 <= (row + row_down_iterater) && (row + row_down_iterater) <= 5) and @board[row][col] == board[row + row_down_iterater][col] #checks down that column
        row_down_iterater += 1
        in_a_col_counter += 1
      end
      break if in_a_col_counter == 3 #if there's 
      if in_a_col_counter == 3 
        puts "#{@player_name} won with that vert column of #{piece}'s!"
        return true
      end
    end
  end
  
  def straight_check_row(piece, row, col)
    in_a_row_counter = 0
    col_left_iterater = 1
    col_right_iterater = 1
    3.times do #check for wins in that row
      if (0 <= (col + col_right_iterater) && (col + col_right_iterater) <= 6) and piece == @board[row][col + col_right_iterater]
        col_right_iterater += 1
        in_a_row_counter += 1
      end
      if (0 <= (col - col_left_iterater) && (col - col_left_iterater) <= 6) and piece == @board[row][col - col_left_iterater]
        col_left_iterater += 1
        in_a_row_counter += 1
      end
      break if in_a_row_counter == 3
      if in_a_row_counter == 3 
        puts "#{@player_name} won with that horiz column of #{piece}'s!"
        return true
      end
    end
  end

  #diagonal wins
  def fwd_diag_check(piece, row, col)
    fwd_diag_counter = 0
    row_up_iterater = 1
    row_down_iterater = 1
    col_left_iterater = 1
    col_right_iterater = 1
    3.times do 
      if (0 <= (col + col_right_iterater) && (col + col_right_iterater) <= 6) and (0 <= (row - row_up_iterater) && (row - row_up_iterater ) <= 5) and @board[row][col] == @board[row - row_up_iterater][col + col_right_iterater]
        col_right_iterater += 1
        row_up_iterater += 1
        fwd_diag_counter += 1
      end
      if (0 <= (col - col_left_iterater) && (col - col_left_iterater) <= 6) and (0 <= (row + row_down_iterater) && (row + row_down_iterater) <= 5) and @board[row][col] == @board[row + row_down_iterater][col - col_left_iterater]
        col_left_iterater += 1
        row_down_iterater += 1
        fwd_diag_counter += 1
      end
      break if fwd_diag_counter == 3 
      if fwd_diag_counter == 3 
        puts "#{@player_name} won with that fwd diag of #{piece}'s!"
        return true
      end
    end
  end

  def bwd_diag_check(piece, row, col)
    bwd_diag_counter = 0
    row_up_iterater = 4
    row_down_iterater = 6
    col_left_iterater = 1
    col_right_iterater = 1
    3.times do 
      if (0 <= (col + col_right_iterater) && (col + col_right_iterater) <= 6) and (0 <= (row + row_down_iterater) && (row + row_down_iterater) <= 5) and @board[row][col] == @board[row + row_down_iterater][col + col_right_iterater]
        col_right_iterater += 1
        row_down_iterater += 1
        bwd_diag_counter += 1
      end
      if (0 <= (col - col_left_iterater) && (col - col_left_iterater) <= 6) and (0 <= (row - row_up_iterater) && (row - row_up_iterater) <= 5) and @board[row][col] == @board[row - row_up_iterater][col - col_left_iterater]
        col_left_iterater += 1
        row_up_iterater += 1
        bwd_diag_counter += 1
      end
      break if bwd_diag_counter == 3 
      if bwd_diag_counter == 3 
        puts "#{@player_name} won with that bwd diag of #{piece}'s!"
        return true
      end
    end
  end

  #ties
  def ties
    false
    tie_token = 0 #each filled column will increment tie token by 1 and if it reaches 7 it means board is full and game is tied
    (0..6).each do |col_num| check_all_col(col_num)? tie_token += 1 : break #for each column, increment tie_token if that column full, else stop 
    end #running the block altogether
    if tie_token == 7
    	return true
    else
    	return false
    end
  end

  def check_all_col(col) #does break break out of the if statement or the block
  	col_full = true #
  	(0..5).each do |row| 
  		next unless @board[row][col] == " " #skips this iteration/this row unless this cell is empty
  		  break #if empty then stop iterating set col_full
  		  col_full = false
  	end
    return col_full
  end

  def find_win(piece, row, col)
  	if (straight_check_row(piece, row, col) || straight_check_row(piece, row, col)) || (fwd_diag_check(piece, row, col) || bwd_diag_check(piece, row, col))
  		puts "#{@player_name}, you have won the game"
  		return true
  	elsif ties == true
  		puts "You've ended the game in a tie"
  		return true
  	end
  	return false
  end
end