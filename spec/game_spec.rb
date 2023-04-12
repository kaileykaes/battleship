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

    it 'human places ships randomly in valid locations' do
    
    end

    it 'takes coordinates from user to place ships' do

    end

    it 'prompts user to enter valid placements if invalid placements' do

    end
    # Computer can place ships randomly in valid locations
    # User can enter valid sequences to place both ships
    # Entering invalid ship placements prompts user to enter valid placements
    

  end

  describe 'board display' do
    it 'renders both game boards (no robo ships revealed)' do 
      @game.robo_board.place(@game.robo_cruiser, ['A1', 'A2', 'A3'])
      @game.robo_board.place(@game.robo_submarine, ['B1', 'C1'])
      @game.human_board.place(@game.human_cruiser, ['B4', 'C4', 'D4'])
      @game.human_board.place(@game.human_submarine, ['A1', 'B1'])
      expect(@game.display_boards).to eq(
        "=============ROBO BOARD=============\n  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n\n=============HUMAN BOARD=============\n  1 2 3 4 \nA S . . . \nB S . . S \nC . . . S \nD . . . S \n"
      )
    end
  end

  describe 'player shots' do 
    it 'player can fire' do
      expect(@game.robo_board.cells['A1'].fired_upon?).to be false
      @game.human_shoot('A1')
      expect(@game.robo_board.cells['A1'].fired_upon?).to be true
    end 

  end
  # Computer chooses a random shot
  # Computer does not fire on the same spot twice
  # Entering invalid coordinate prompts user to enter valid coordinate
  # Both computer and player shots are reported as a hit, sink, or miss
  # User is informed when they have already fired on a coordinate
  # Board is updated after a turn
  
  describe 'end game' do
    # Game ends when all the user’s ships are sunk
    # Game ends when all the computer’s ships are sunk
    # Game reports who won
    # Game returns user back to the Main Menu
  end
  
  describe 'helpers' do 
    it '#unfired_cells' do 
      expect(@game.unfired_cells(@game.robo_board)).to eq([
        'A1', 'A2', 'A3', 'A4', 'B1', 'B2', 
        'B3', 'B4', 'C1', 'C2', 'C3', 'C4', 
        'D1', 'D2', 'D3', 'D4' 
        ])
        expect(@game.unfired_cells(@game.human_board)).to eq([
          'A1', 'A2', 'A3', 'A4', 'B1', 'B2', 
          'B3', 'B4', 'C1', 'C2', 'C3', 'C4', 
          'D1', 'D2', 'D3', 'D4' 
          ])
        end
    
    it '#valid_human_shot?' do 
      expect(@game.valid_human_shot?('B5')).to eq('No. Check your aim. Set another coordinate in your sights.')
      expect(@game.valid_human_shot?('A1')).to eq('KABOOM')
    end
  end
end