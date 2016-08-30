
load 'player.rb'
load 'board.rb'


#Tell players about game rules --- will consider revamping this introduction and prompt for game mode etc into a separate method if i can get the
#other shit to work
gametype = "asd"

unless gametype == 'PVP' || gametype == 'AI' 
  puts "To start a two player game, please enter 'PVP'. To start a game against AI, please enter 'AI'"
  gametype = gets.chomp.to_s
end

puts "Please enter name for Player 1 "

player1 = gets.chomp.to_s

if gametype == 'PVP'
  puts "Please enter name for Player 2\n "
  player2 = gets.chomp.to_s
end

#prompt for players definitions and shovel them into @players
players = [Player.new(:name => player1, :species => "human", :symbol => "X"), Player.new(:name => player1, :species => "human", :symbol => "O")] if gametype == 'PVP'
players = [Player.new(:name => player1, :species => "human", :symbol => "X"), Player.new(:name => player1, :species => "AI", :symbol => "O")] if gametype == 'AI'

#turn system
current_player_indice = 0

def next_player
	current_player_indice = (current_player_indice + 1) % players.size
end
def current_player
	return players[current_player_indice]
end
def prompt_move(player)
  puts " #{player}'s turn. Choose a column!",
  col_num = gets.chomp.to_i - 1
  return col_num
end

#clearing the screen
  def refresh
  	puts "\n" * 50
  end 

#game engine
  def game_engine
    while false
      active = current_player
      col_num = prompt_move(active)
      #while !valid_move(col_num) do prints "Please choose another column which is NOT filled up and ON the board"
     # 	col_num = prompt_move(active)
     # end 
      drop_piece(col_num) #@row now contains the row number of that the piece was dropped into
      board.printboard
      return true if board.win #check winning conditions
      board.row = 0
      next_player #change current_player indice to be set for next player.
    end
  end

#instantiate board class object.
  def connect4(boardClass)
  	board = boardClass.new
  	refresh
  	board.printCoords
  	refresh
  	board.printboard
  	game_engine
  end

connect4(Board)

#while true
#  refresh
#  puts "Want to play again? (y/n)" 
#  if ["no", "n"].include? (gets.chomp.downcase)
#  	puts "Hope you had fun, goodbye"
#  	break
#  end
#  puts "Okay game will restart"
#  connect4(Board)
#end