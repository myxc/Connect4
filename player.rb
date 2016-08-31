class Player
  def initialize(name, species, symbol) #When instantiating Player, the attributes will be given in an options hash 
    @name = name
    @species = species
    @player_piece = symbol
  end