class Player
  def initialize(name, species, symbol) #When instantiating Player, the attributes will be given in an options hash 
    @name = name
    @species = species
    @player_piece = symbol
  end
  attr_reader :name, :species, :player_piece
end 
#species of the player will determine if there will be a CPU in the game.
#the player_piece of each player will be based off who was the first player to be created
#i.e. Mark = Player.new(name: "Mark", species: "human")
#or Computron3 = Player.new(:name => "Computron3", :species => "AI")