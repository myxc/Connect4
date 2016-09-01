class Board
	attr_accessor :board, :player1, :row, :col, :piece, :player1, :player2
	def initialize
		@board = Array.new(6) { Array.new(7," ")}
		@player1 = "X"
		@player2 = "O"
		@piece = "X"
		@row = 4
		@col = 3
	end
	#turn system
	def current_player
		@current_player = @player1
		#@player_name = @current_player.player_name
	end

	def next_player
		if @current_player == @player1
		  @current_player = @player2
		else
			@current_player = @player1
		end
		@piece = @current_player #set new player's piece as "piece"
	end 

	def get_coords
		puts "#{@piece} please enter the row and col number that you want to drop your piece into \n"
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
  def inside_board #true as long as @col_num has a value between 0 and 6 aka will be in element 1 thru 7 on any row
    if 0 <= @col && @col <= 6
      if 0 <= @row && @row <= 5
      	return true
      else 
      	return false
      end
    else
    	return false
    end
  end

  def valid_drop #based on given row and col
  	if inside_board 	#valid is empty and also inside grid and has no empty cells below it
  		if @board[@row][@col] == " "
  		  puts "you good"
  		  return true
  		else 
  			puts "aint empty"
  			return false
  		end
  	else
  		puts "aint vlid"
  		return false
  	end
  end

  def drop_piece
    if valid_drop == true 
    	@board[@row][@col] = @piece 
    	puts "piece got dropped"
    	return true 
    else
    	puts "your row and/or col values are not valid" 
    	return false
    end
  end
  #ternary is mainly for assignments, and can only handle one operation on either side of the : 

  #win conditions:
  #straight wins
  def straight_check_col
    @in_a_col_counter = 0
    @row_up_iterater = 1
    @row_down_iterater = 1

    3.times do #check for wins in that column
      if (0 <= (@row - @row_up_iterater) && (@row - @row_up_iterater) <= 5) && ((0 <= @col) and (@col <= 6))
        if  @board[@row][@col] == board[@row - @row_up_iterater][@col] #checks up that column
            @row_up_iterater += 1 #if that cell is the same then increments the @row iterater so next loop will check the one even farther out
            @in_a_col_counter += 1 #increments column counter if it is the same
        end
      end
      if (0 <= (@row + @row_down_iterater) && (@row + @row_down_iterater) <= 5) && ((0 <= @col) and (@col <= 6))
        if  @board[@row][@col] == board[@row + @row_down_iterater][@col] #checks down that column
          @row_down_iterater += 1
          @in_a_col_counter += 1
        end
      end
    end
    if @in_a_col_counter == 3 
      puts "#{@piece} won with that horiz column of #{piece}'s!"
      return true
    else
    	return false
    end
  end

  
  def straight_check_row
    @in_a_row_counter = 0
    @col_left_iterater = 1
    @col_right_iterater = 1
    3.times do #check for wins in that row
      if (0 <= (@col + @col_right_iterater) && (@col + @col_right_iterater) <= 6) && ((0 <= @row) and (@row <= 5))
      	if  piece == @board[@row][@col + @col_right_iterater]
          @col_right_iterater += 1
          @in_a_row_counter += 1
        end  
      end
      if (0 <= (@col - @col_left_iterater) && (@col - @col_left_iterater) <= 6) && ((0 <= @row) and (@row <= 5))
      	if  piece == @board[@row][@col - @col_left_iterater]
          @col_left_iterater += 1
          @in_a_row_counter += 1
        end
      end
    end
    if @in_a_row_counter == 3 
      puts "#{@piece} won with that horiz column of #{piece}'s!"
      return true
    else
    	return false
    end
  end

  #diagonal wins
  def fwd_diag_check
    @fwd_diag_counter = 0
    @row_up_iterater = 1
    @row_down_iterater = 1
    @col_left_iterater = 1
    @col_right_iterater = 1
    3.times do 
      if (0 <= (@col + @col_right_iterater) && (@col + @col_right_iterater) <= 6) and (0 <= (@row - @row_up_iterater) && (@row - @row_up_iterater ) <= 5) 
        if @board[@row][@col] == @board[@row - @row_up_iterater][@col + @col_right_iterater]
          @col_right_iterater += 1
          @row_up_iterater += 1
          @fwd_diag_counter += 1
        end
      end
      if (0 <= (@col - @col_left_iterater) && (@col - @col_left_iterater) <= 6) and (0 <= (@row + @row_down_iterater) && (@row + @row_down_iterater) <= 5)
      	if @board[@row][@col] == @board[@row + @row_down_iterater][@col - @col_left_iterater]
          @col_left_iterater += 1
          @row_down_iterater += 1
          @fwd_diag_counter += 1
        end
      end
    end
    if @fwd_diag_counter == 3 
      puts "#{@piece} won with that horiz column of #{piece}'s!"
      return true
    else
    	return false
    end
  end


  def bwd_diag_check
    @bwd_diag_counter = 0
    @row_up_iterater = 1
    @row_down_iterater = 1
    @col_left_iterater = 1
    @col_right_iterater = 1
    3.times do 
      if ((0 <= (@col + @col_right_iterater)) && (@col + @col_right_iterater) <= 6) and ((0 <= (@row + @row_down_iterater)) && ((@row + @row_down_iterater) <= 5)) 
      	if  @board[@row][@col] == @board[@row + @row_down_iterater][@col + @col_right_iterater]
          @col_right_iterater += 1
          @row_down_iterater += 1
          @bwd_diag_counter += 1
        end
      end
      if (0 <= (@col - @col_left_iterater) && (@col - @col_left_iterater) <= 6) and (0 <= (@row - @row_up_iterater) && (@row - @row_up_iterater) <= 5)
      	if  @board[@row][@col] == @board[@row - @row_up_iterater][@col - @col_left_iterater]
          @col_left_iterater += 1
          @row_up_iterater += 1
          @bwd_diag_counter += 1
        end
      end
    end
    if @bwd_diag_counter == 3 
      puts "#{@piece} won with that horiz column of #{piece}'s!"
      return true
    else
    	return false
    end
  end

  def ties
    @board.join.split(' ').include?(" ")  
  end

  def find_win
  	puts "checking for win"
  	straight_check_row
  	straight_check_col
  	fwd_diag_check
  	bwd_diag_check
  	if straight_check_row
  		puts "#{@piece}, you have won the game"
  		return true
  	end
  	if straight_check_row
  		puts "#{@piece}, you have won the game"
  		return true
  	end
  	if fwd_diag_check
  		puts "#{@piece}, you have won the game"
  		return true
  	end
   	if bwd_diag_check
  		puts "#{@piece}, you have won the game"
  		return true
  	end
  	if ties == true
  		puts "You've ended the game in a tie"
  		return true
  	end
  	return false
  end
end