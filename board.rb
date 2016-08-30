class Board
  def initialize
    @board = Array.new(6) { Array.new(7, "0") }
    @row = 0
  end

  attr_reader :row :board 
  def printCoords
    puts "row6:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
         "--------------------------------",
         "row5:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
         "--------------------------------",
         "row4:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
         "--------------------------------",
         "row3:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
         "--------------------------------",
         "row2:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
         "--------------------------------",
         "row1:(1)|(2)|(3)|(4)|(5)|(6)|(7)",
    print "\n"
  end

  def printboard
    (0..5).each do |row|
      (0..6).each do |col|
        print @board[-1 - row][col]
        print "|" unless col == 6
      end
      print "-------------\n" unless row == 5
    end
  end

  def inside_board(col_num)
    (0..6) == col_num
  end

  def has_room(col_num)
    (0..5).any? do |row|
  	  next unless @board[-1 - row][col_num] == 0
    end
  end

  def valid_move(col_num)
    inside_board(col_num) and has_room(col_num)
  end

  def drop_piece(col_num)
    (0..5).each do |row|
      @row = 0
      next unless @board[-1 - row][col_num] == 0
      @row = row
      break
    end
    @board[-1 - @row][col_num] = @player_piece
  end






