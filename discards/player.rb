class Player
	attr_reader :name, :species, :player_piece
  def initialize(name, species, symbol) #When instantiating Player, the attributes will be given in an options hash 
    @name = name
    @species = species
    @player_piece = symbol
  end
end