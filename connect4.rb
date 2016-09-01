load 'board.rb'

def refresh #for sake of final output not all jumbled together
	print "\n" * 25
end

def connect4(boardClass)
	board = boardClass.new #create board class
	board.current_player #to assign current player as player 1
	puts "Do you want to play against an AI? (y/n)"
	if ["y", "yes"].include?(gets.to_s.downcase.strip)
		board.AI_mode = "ON" #need to look at this
	end
  loop do #keep looping until the game is done
  	refresh #to make things seem less cluttered
	  board.print_coords #print grid layout
  	board.print_board #print actual game board
  	#board.get_coords #prompt player for column number that they wish to drop piece into
  	loop do
  	  board.get_coords
  	  if board.has_room == true
  	    break
  	  end
  	end  	
  	#until board.has_room == true #until loop that will repeat until has_room is true
  	#	puts "until loop for has_room"
  	#	board.get_coords #prompt player for coords
  	#end
  	board.drop_piece
  	board.print_coords
  	board.print_board
		#board.find_win
		break if board.find_win == true
		board.next_player
	end
end

connect4(Board)