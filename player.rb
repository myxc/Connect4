class Player
  def initialize(name, species, symbol) #When instantiating Player, the attributes will be given in an options hash 
    @name = name
    @species = species
    @player_piece = symbol
  end

	#player def
  def create #creates array populated by default players
  @players = []
  @players[0] = Player.new("player1", "human", "X")
  @players[1] = Player.new("player2", "human", "O")
  end
	
	#turn system
  def current_player
    @current_player = @players[1]
    @piece = @current_player.player_piece
    @player_name = @current_player.name
  end

  def next_player
    @current_player = @e.peek if @piece == "X"
    @current_player = @e.next if @piece == "O"
    @piece = @current_player.player_piece
    @player_name = @current_player.name
    end
  end 

#species of the player will determine if there will be a CPU in the game.
#the player_piece of each player will be based off who was the first player to be created
#i.e. Mark = Player.new(name: "Mark", species: "human")
#or Computron3 = Player.new(:name => "Computron3", :species => "AI")