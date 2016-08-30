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
#needs to be fixed
def next_player
	@current_player_indice = (@current_player_indice + 1) % @players.size
end
def current_player
	return @players[current_player_indice]
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

#make sure the move is valid i.e. the column isn't full, the column exists etc.
#check win conditions i.e. horizontally, vertically and diagonally with each new move so that there's less to think about, using and statements?
#alert players that one of them has won

#instantiate board class object.
  def connect4(Board = Board)
  	board = Board.new
  	refresh
  	board.printCoords

    while not board.win
      @current_player = current_player
      col_num = prompt_move(@current_player)
      while !valid_move(col_num) prints "Please choose another column which is NOT filled up and ON the board"
      	col_num = prompt_move(@current_player)
      end 
      drop_piece(col_num) #@row now contains the row number of that the piece was dropped into
      board.printboard
      board.win #check winning conditions
      next_player #change current_player indice to be set for next player.
    end
  end

connect4(Board)

while true
  refresh
  puts "Want to play again? (y/n)" 
  if ["no", "n"].include? (gets.chomp.downcase)
  	puts "Hope you had fun, goodbye"
  	break
  end
  if ["yes", "y"].include? (gets.chomp.downcase)
  	puts "Okay game will restart"
  	connect4(Board)
  end
end