load 'board2.rb'

def refresh #for sake of final output not all jumbled together
	print "\n" * 25
end

def connect4(boardClass)
	board = boardClass.new #create board class
	board.current_player #to assign new values to the current player instance vars]
	board.print_coords #print grid layout
	board.print_board #print actual game board
  loop do
  	board.get_coords
  	board.drop_piece
  	board.print_coords
  	board.print_board
		#board.find_win
		break if board.find_win == true
		board.next_player
	end
end

connect4(Board)