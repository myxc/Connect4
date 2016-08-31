load 'board2.rb'

def refresh #for sake of final output not all jumbled together
	print "\n" * 25
end

def connect4(boardClass)
	board = boardClass.new #create board class
	board.current_player #to assign new values to the current player instance vars
	puts @current_player
	puts @piece
	puts @player_name #tests to see if the values assigned properly
	board.print_coords #print grid layout
	board.print_board #print actual game board
	refresh#make some space
  loop do
  	board.get_coords
  	board.drop_piece(@piece, @row, @col)
		while board.drop_piece(@piece, @row, @col) == false #drop piece returns false if row and col aren't valid moves
			get_coords #get new values for row and col
			board.drop_piece(@piece, @row, @col) #using new values try to drop piece again, if it drops and returns true then board 
		end
		board.find_win(@piece, @row, @col)
		break if board.find_win(@piece, @row, @col) == true
		board.next_player
	end
end

connect4(Board)