class Board
	attr_accessor :board, :player1, :row, :col, :piece, :player1, :player2, :AI_mode
	def initialize
		@board = Array.new(6) { Array.new(7," ")}
		@player1 = "X"
		@player2 = "O"
		@piece = "X"
		@row = 0
		@col = 8
    @AI_mode = "OFF"
    @row_counter = Array.new(7, 0) #After you get @col input, check to see what row to put the piece based on the value in the corresponding element
    #this value will increment after each time a piece is dropped into that column, and when the value reaches 5, it will indicate that the column is full 
    #This way, ties will also be easy to see, because every element inside @row_counter will be 6 when board is full.
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
    puts "player changed"
		@piece = @current_player #set new player's piece as "piece"
	end 

	def get_coords
		if @AI_mode == "ON"
      if @current_player == @player2
        @col = rand(0..6)
        puts "using rando powers"
      end
      if @current_player == @player1
        puts "#{@piece} please enter the number for the column that you want to drop your piece into \n"
		    puts "Col: "
        puts " from ai true branch"
		    @col = (gets.chomp.to_i) - 1 #user input stored into col
      end
    else 
      puts "#{@piece} please enter the number for the column that you want to drop your piece into \n"
      puts "Col: "
      puts "from else branch"
      puts "#{@AI_mode}"
      @col = (gets.chomp.to_i) - 1 #user input stored into col
    end
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
  def has_room #take @col value and check if there's room, reprompting for another @col value if this returns false.
    if (0 <= @col) && (@col <= 6) #input @col is on the board
      if @row_counter[@col] <= 5 #that column has room
        puts "has room" #for debug pursposes
        @row = (5 - (@row_counter[@col])) #set @row value to be the same as the value of the row available
        return true #return true for chaining purposes
      end
      if @row_counter[@col] == 6 #if row is full
        puts "that column is full boi" #debug msg
        return false #return false to show there's no room
      end
    else
      puts "your column value is not on the board"
      return false
    end
  end

  def drop_piece #drops the piece after you've made sure that there won't be any hiccups
    	@board[@row][@col] = @piece  #assign that empty row with the piece
    	puts "piece got dropped" #debug msg
      @row_counter[@col] += 1 #increment the value of the row counter
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
    if @in_a_col_counter >= 3 
      puts "#{@piece} won with that vert column of #{piece}'s!"
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
    if @in_a_row_counter >= 3 
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
    if @fwd_diag_counter >= 3 
      puts "#{@piece} won with that fwd diag of #{piece}'s!"
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
    if @bwd_diag_counter >= 3 
      puts "#{@piece} won with that bwd diag column of #{piece}'s!"
      return true
    else
    	return false
    end
  end

  def ties
    @tie_counter = 0 #counter for how many columns are full
    (0..6).each do |col| #for columns 0 to 6 aka all 7 columns
      if @row_counter[col] == 6 #if the row counter is 6 then that column is full
        @tie_counter += 1 #increment tie counter
      else
        break #break out of this block if any column is not full
      end
    end
    if @tie_counter == 7 #all columns are filled
      return true #true to ties
    else
      return false #false to ties
    end
  end

  def find_win
  	puts "checking for win"
#  	straight_check_row
#  	straight_check_col
#  	fwd_diag_check
#  	bwd_diag_check
  	if straight_check_row
  		puts "#{@piece}, you have won the game with 4 in a row"
  		return true
  	end
  	if straight_check_col
  		puts "#{@piece}, you have won the game with 4 in a column"
  		return true
  	end
  	if fwd_diag_check
  		puts "#{@piece}, you have won the game with 4 diagonally"
  		return true
  	end
   	if bwd_diag_check
  		puts "#{@piece}, you have won the game with 4 diagonally"
  		return true
  	end
  	if ties == true
  		puts "You've ended the game in a tie"
  		return true
  	end
  	return false
  end
end