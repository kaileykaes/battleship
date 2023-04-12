require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/game"

RSpec.describe 'Game' do
  before(:each) do
    @game = Game.new
  end

  describe 'game' do
    it 'exists' do
      expect(@game).to be_an_instance_of(Game)
    end

    it 'has attributes' do
      expect(@game.human_board).to be_a(Board)
      expect(@game.robo_board).to be_a(Board)
      expect(@game.robo_cruiser).to be_a(Ship)
      expect(@game.robo_submarine).to be_a(Ship)
      expect(@game.human_cruiser).to be_a(Ship)
      expect(@game.human_submarine).to be_a(Ship)
    end
  end

  describe 'main menu' do
    it 'prints a welcome message' do
      expect(@game.main_menu).to eq("Welcome to BATTLESHIP\n Enter p to play. Enter q to quit.")
    end
  end

  describe 'setup' do
    it 'robo places ships randomly in valid locations' do
      expect(@game.robo_board.ships.empty?).to be true
      @game.robo_place_ship
      # require 'pry'; binding.pry
      expect(@game.robo_board.ships).to eq([@game.robo_cruiser, @game.robo_submarine])
    end

    it 'human places ships in valid locations' do
      @game.human_place_ship(@game.human_cruiser)
      @game.human_place_ship(@game.human_submarine)
      @game.human_place_ship(@game.human_cruiser, ["A1", "A2", "A3"])
      expect(@game.human_board.cells["A1"].ship).to be_a(Ship)
    end

    it 'takes coordinates from user to place ships' do
      expect(@game.human_board.ships).to eq([])
      @game.human_place_ship(@game.human_cruiser)
      @game.human_place_ship(@game.human_submarine)
      expect(@game.human.ships).to eq([@game.human_cruiser, @game.human_submarine])
    end

    it 'prompts user to enter valid placements if invalid placements' do
      expect(@game.human_place_ship).to eq("Try again with valid coordinates")
    end
    # Computer can place ships randomly in valid locations
    # User can enter valid sequences to place both ships
    # Entering invalid ship placements prompts user to enter valid placements
    

  end

  describe 'turn' do
    # User board is displayed showing hits, misses, sunken ships, and ships
    # Computer board is displayed showing hits, misses, and sunken ships
    # Computer chooses a random shot
    # Computer does not fire on the same spot twice
    # User can choose a valid coordinate to fire on
    # Entering invalid coordinate prompts user to enter valid coordinate
    # Both computer and player shots are reported as a hit, sink, or miss
    # User is informed when they have already fired on a coordinate
    # Board is updated after a turn
  end

  describe 'end game' do
    # Game ends when all the user’s ships are sunk
    # Game ends when all the computer’s ships are sunk
    # Game reports who won
    # Game returns user back to the Main Menu
  end
end