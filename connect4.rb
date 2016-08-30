load 'board.rb'

#clearing the screen
  def refresh
  	puts "\n" * 50
  end 

#game engine
#  def game_engine
#    while true#
#
#    end
#  end

#instantiate board class object.
  def connect4(boardClass)
  	board = boardClass.new
  	refresh
  	board.game_mode
  	board.printCoords
  	refresh
  	board.printboard
      active = board.current_player
      col_num = board.prompt_move(active)
      while !board.valid_move(col_num) do puts "Please choose another column which is NOT filled up and ON the board"
     	col_num = board.prompt_move(active)
      end 
      board.drop_piece(col_num) #@row now contains the row number of that the piece was dropped into
      refresh
      board.printboard
      return false if board.win #check winning conditions
      board.row = 0
      next_player #change current_player indice to be set for next player.
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