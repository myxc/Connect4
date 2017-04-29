require_relative "./board"
require_relative "./ai"

def player_move
  puts "Choose a column (1-7): "
  move = gets.chomp.to_i
  column = move - 1
end

board = Board.new
loop do
  board.print
  column = player_move
  board = board.make_move column, "X"
  break if board.winner
  board = board.make_move AI.new("O").pick_move(board), "O"
  break if board.winner
end

board.print
puts "The winner is: #{board.winner}"
