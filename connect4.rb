require board.rb
require player.rb

#Tell players about game rules
gametype = nil

unless gametype == 'PVP' || 'AI' 
  print "To start a two player game, please enter 'PVP'. To start a game against AI, please enter 'AI'\n"
  gametype = gets.chomp
end

prints "Please enter name for Player 1\n "

player1 = gets.chomp

if gametype == 'PVP'
  prints "Please enter name for Player 2\n "
  player2 = gets.chomp
end

#prompt for players definitions and shovel them into @players
@players = [Player.new(:name => player1, :species => human, :symbol => "X"), Player.new(:name => player1, :species => human, :symbol => "O")] if gametype == 'PVP'
@players = [Player.new(:name => player1, :species => human, :symbol => "X"), Player.new(:name => player1, :species => AI, :symbol => "O")] if gametype == 'AI'

#turn system
@current_player_indice = 0

def next_player
	@current_player_indice = (@current_player_indice + 1) % @players.size
end
def prompt_move(current_player)
  puts " #{current_player}'s turn. Choose a column!",
  col_num = gets.chomp.to_i - 1
  return col_num
end

#clearing the screen
  def refresh
  	puts "\n" * 100
  end 
#@row contains the row number that the piece is dropped into and the column number is already known, these will be useful to find whether the surrounding 6 spaces
#vertically/horizontally/diagonally will contain the tiles needed for a win
#win conditions:
  #straight wins
  def straight_check_col
    in_a_row_counter = 0
    row_up_iterater = 4
    row_down_iterater = 6

    2.times do #check for wins in that column
      if (0 <= (row_up_iterater - @row) <= 5) and @player_piece == @board[(row_up_iterater - @row)][col_num]
      	row_up_iterater -= 1
      	in_a_col_counter += 1
      end
      if (0 <= (row_down_iterater - @row) <= 5) and @player_piece == @board[(row_down_iterater - @row)][col_num]
      	row_down_iterater += 1
      	in_a_col_counter += 1
      end
      if in_a_row_counter == 3 break prints "#{current_player} is the winner!"
      end
    end
    in_a_row_counter = 0
    row_up_iterater = 4
    row_down_iterater = 6
  end
  
  def straight_check_row
    in_a_col_counter = 0
    col_left_iterater = 1
    col_right_iterater = 1
    2.times do #check for wins in that row
      if (0 <= (col_num + col_right_iterater) <= 6) and @player_piece == @board[(5 - @row)][col_num + col_right_iterater]
      	col_right_iterater += 1
      	in_a_col_counter += 1
      end
      if (0 <= (col_num - col_left_iterater) <= 6) and @player_piece == @board[(5 - @row)][col_num - col_left_iterater]
      	col_left_iterater += 1
      	in_a_col_counter += 1
      end
      if in_a_col_counter == 3 break prints "#{current_player} is the winner!"
      end
    end
    in_a_col_counter = 0
    col_left_iterater = 1
    col_right_iterater = 1
  end
  #diagonal wins
  def backslash_diag_check
  	back_diag_counter = 0
    row_up_iterater = 4
    row_down_iterater = 6
    col_left_iterater = 1
    col_right_iterater = 1
  	2.times do #will need to finesse this and get the logistics right.
      if (0 <= (col_num + col_right_iterater) <= 6) and (0 <= (row_up_iterater - @row) <= 5)
      	col_right_iterater += 1
      	in_a_col_counter += 1
      end

  end

  def forwardslash_diag_check
  	...
  end

  #ties
  def ties
    (0..6).each do |col_num| has_room(col_num)? break return false : break return true
  end

  def win 
  	if ties == true prints "Both players have ended the game in a tie" return true
  	end
    if (straight_check_row || straight_check_col) || (diag_check
  end

#make sure the move is valid i.e. the column isn't full, the column exists etc.
#check win conditions i.e. horizontally, vertically and diagonally with each new move so that there's less to think about, using and statements?
#alert players that one of them has won

#instantiate board class object.
  def connect4(Board = Board)
  	board = Board.new
  	refresh
  	board.printCoords

    while not win
      @current_player = @players[@current_player_indice]
      col_num = prompt_move(@current_player)
      while !valid_move(col_num) prints "Please choose another column which is NOT filled up and ON the board"
      	col_num = prompt_move(@current_player)
      end 
      drop_piece(col_num) #@row now contains the row number of that the piece was dropped into
      board.printboard

      #check winning conditions based on the 6 shits diagonally/straight adjacent to that row/col piece
      #if not win or tie

      next_player
  end





