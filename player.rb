class Player
  def initialize(attrs) #When instantiating Player, the attributes will be given in an options hash 
    @name = attrs[:name]
    @species = attrs[:species]
    @player_piece = attrs[:symbol]
  end
  attr_reader :species :player_piece
end 
#species of the player will determine if there will be a CPU in the game.
#the player_piece of each player will be based off who was the first player to be created
#i.e. Mark = Player.new(name: "Mark", species: "human")
#or Computron3 = Player.new(:name => "Computron3", :species => "AI")