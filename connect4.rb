load 'board.rb'

#clearing the screen
  def refresh
  	puts "\n" * 5
  end 

#instantiate board class object.
  def connect4(boardClass)
  	board = boardClass.new
  	refresh
  	board.testboard
  	#board.game_mode #decide on PVP or AI and enter char names
  	refresh
  	board.printCoords #outputs sample of game box to show how coords work
  	refresh
  	board.printboard #print board by outputting parts of @board separated with | and ---
    active = board.current_player #active player variable set by current_player class method 
    board.prompt_move(active) #request column number from active player 
    while board.valid_move == false do puts "Please choose another column which is NOT filled up and ON the board" #checks whether the column input is a valid move
      board.prompt_move(active) #asks for another number if it is not
    end 
    board.drop_piece #@row now contains the row number of that the piece was dropped into 
    refresh
    board.printboard
    return false if board.win #check winning conditions
    board.row = 0
    next_player #change current_player indice to be set for next player.
    end

connect4(Board)
