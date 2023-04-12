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

    it 'boards are updated after a turn' do 
      @game.robo_board.place(@game.robo_cruiser, ['A1', 'A2', 'A3'])
      @game.robo_board.place(@game.robo_submarine, ['B1', 'C1'])
      @game.human_board.place(@game.human_cruiser, ['B4', 'C4', 'D4'])
      @game.human_board.place(@game.human_submarine, ['A1', 'B1'])
      expect(@game.display_boards).to eq(
        "=============ROBO BOARD=============\n  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n\n=============HUMAN BOARD=============\n  1 2 3 4 \nA S . . . \nB S . . S \nC . . . S \nD . . . S \n"
      )

      @game.human_shoot('A2') 
      @game.human_board.cells['B1'].fire_upon
      expect(@game.display_boards).to eq(
        "=============ROBO BOARD=============\n  1 2 3 4 \nA . H . . \nB . . . . \nC . . . . \nD . . . . \n\n=============HUMAN BOARD=============\n  1 2 3 4 \nA S . . . \nB H . . S \nC . . . S \nD . . . S \n"
      )
    end
  end
  
  describe 'player shots' do 
    it 'player can fire' do
      expect(@game.robo_board.cells['A1'].fired_upon?).to be false
      @game.human_shoot('A1')
      expect(@game.robo_board.cells['A1'].fired_upon?).to be true
    end 

    it 'cannot fire on invalid coordinates' do 
      expect(@game.robo_board.valid_coordinate?('B5')).to be false
      expect(@game.human_shoot('B5')).to eq(nil)
    end
    
    it 'result message after a shot' do 
      @game.robo_board.place(@game.robo_cruiser, ['A1', 'A2', 'A3'])
      @game.robo_board.place(@game.robo_submarine, ['B1', 'C1'])
      expect{ @game.human_shoot('A4') }.to output('Whoops. Missed.').to_stdout
      expect{ @game.human_shoot('B1') }.to output('Yippee!! Ship struck!').to_stdout
      expect{ @game.human_shoot('C1') }.to output('Sunken ship!').to_stdout      
    end
  end

  describe 'robo shots' do 
    it 'robo can fire' do
      @game.robo_shoot
      expect(@game.unfired_cells(@game.human_board).length).to eq(15)
    end 

    it 'result message after robo shot' do 
      @game.human_board.place(@game.human_cruiser, ['B4', 'C4', 'D4'])
      @game.human_board.place(@game.human_submarine, ['A1', 'B1'])
      expect{ @game.robo_shoot }.to output('Whoops. Missed.'|| 'Yippee!! Ship struck!' || 'Sunken ship!').to_stdout      
    end
  end

  # Entering invalid coordinate prompts user to enter valid coordinate
  # Both computer and player shots are reported as a hit, sink, or miss
  # User is informed when they have already fired on a coordinate
  # Board is updated after a turn
  
  describe 'end game' do
    it 'ends if human ships are sunk' do 
      @game.robo_board.place(@game.robo_cruiser, ['A1', 'A2', 'A3'])
      @game.robo_board.place(@game.robo_submarine, ['B1', 'C1'])
      @game.human_board.place(@game.human_cruiser, ['B4', 'C4', 'D4'])
      @game.human_board.place(@game.human_submarine, ['A1', 'B1'])
      @game.human_board.cells['A1'].fire_upon
      @game.human_board.cells['B1'].fire_upon
      @game.human_board.cells['B4'].fire_upon
      @game.human_board.cells['C4'].fire_upon
      @game.human_board.cells['D4'].fire_upon
      expect(@game.game_over?).to be true
    end
    
    it 'ends when robo ships are sunk' do 
      @game.robo_board.place(@game.robo_cruiser, ['A1', 'A2', 'A3'])
      @game.robo_board.place(@game.robo_submarine, ['B1', 'C1'])
      @game.human_board.place(@game.human_cruiser, ['B4', 'C4', 'D4'])
      @game.human_board.place(@game.human_submarine, ['A1', 'B1'])
      @game.human_shoot('A1')
      @game.human_shoot('A2')
      @game.human_shoot('A3')
      @game.human_shoot('B1')
      @game.human_shoot('C1')
      expect(@game.game_over?).to be true
    end
    
    xit 'unless all of one players ships are sunk, not over' do 
      @game.robo_board.place(@game.robo_cruiser, ['A1', 'A2', 'A3'])
      @game.robo_board.place(@game.robo_submarine, ['B1', 'C1'])
      @game.human_board.place(@game.human_cruiser, ['B4', 'C4', 'D4'])
      @game.human_board.place(@game.human_submarine, ['A1', 'B1'])
      @game.human_shoot('A1')
      @game.human_shoot('A2')
      @game.human_shoot('A3')
      @game.human_board.cells['B1'].fire_upon
      @game.human_board.cells['B4'].fire_upon
      @game.human_board.cells['C4'].fire_upon
      @game.human_board.cells['D4'].fire_upon
      expect(@game.game_over?).to be false
    end

    xit 'determines human winner' do 
      @game.robo_board.place(@game.robo_cruiser, ['A1', 'A2', 'A3'])
      @game.robo_board.place(@game.robo_submarine, ['B1', 'C1'])
      @game.human_board.place(@game.human_cruiser, ['B4', 'C4', 'D4'])
      @game.human_board.place(@game.human_submarine, ['A1', 'B1'])
      @game.human_shoot('A1')
      @game.human_shoot('A2')
      @game.human_shoot('A3')
      @game.human_shoot('B1')
      @game.human_shoot('C1')
      expect(@game.winner).to eq(:human)
    end
    
    xit 'determines robo winner' do 
      @game.robo_board.place(@game.robo_cruiser, ['A1', 'A2', 'A3'])
      @game.robo_board.place(@game.robo_submarine, ['B1', 'C1'])
      @game.human_board.place(@game.human_cruiser, ['B4', 'C4', 'D4'])
      @game.human_board.place(@game.human_submarine, ['A1', 'B1'])
      @game.human_board.cells['A1'].fire_upon
      @game.human_board.cells['B1'].fire_upon
      @game.human_board.cells['B4'].fire_upon
      @game.human_board.cells['C4'].fire_upon
      @game.human_board.cells['D4'].fire_upon
      expect(@game.winner).to eq(:robo)
    end

    xit '#end_game if robo winner' do 
      @game.robo_board.place(@game.robo_cruiser, ['A1', 'A2', 'A3'])
      @game.robo_board.place(@game.robo_submarine, ['B1', 'C1'])
      @game.human_board.place(@game.human_cruiser, ['B4', 'C4', 'D4'])
      @game.human_board.place(@game.human_submarine, ['A1', 'B1'])
      @game.human_board.cells['A1'].fire_upon
      @game.human_board.cells['B1'].fire_upon
      @game.human_board.cells['B4'].fire_upon
      @game.human_board.cells['C4'].fire_upon
      @game.human_board.cells['D4'].fire_upon
      expect{@game.end_game}.to output('Robo wins!').to_stdout
    end

    xit '#end_game if human winner' do 
      @game.robo_board.place(@game.robo_cruiser, ['A1', 'A2', 'A3'])
      @game.robo_board.place(@game.robo_submarine, ['B1', 'C1'])
      @game.human_board.place(@game.human_cruiser, ['B4', 'C4', 'D4'])
      @game.human_board.place(@game.human_submarine, ['A1', 'B1'])
      @game.human_shoot('A1')
      @game.human_shoot('A2')
      @game.human_shoot('A3')
      @game.human_shoot('B1')
      @game.human_shoot('C1')
      expect{@game.end_game}.to output('You win!').to_stdout
    end
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
    
    it '#human_shot_validation' do 
      expect(@game.human_shot_validation('B5')).to eq('No. Check your aim. Set another coordinate in your sights.')
      expect(@game.human_shot_validation('A1')).to eq('KABOOM')
      @game.human_shoot('A1')
      expect(@game.human_shot_validation('A1')).to eq('You already shot there, remember? Try again.')
    end

    it '#results' do 
      @game.robo_board.place(@game.robo_cruiser, ['A1', 'A2', 'A3'])
      @game.robo_board.place(@game.robo_submarine, ['B1', 'C1'])
      @game.human_shoot('A4')
      expect(@game.results(@game.robo_board, 'A4')).to eq('Whoops. Missed.')
      @game.human_shoot('B1')
      expect(@game.results(@game.robo_board,'B1')).to eq('Yippee!! Ship struck!')
      @game.human_shoot('C1')
      expect(@game.results(@game.robo_board,'C1')).to eq('Sunken ship!')
    end
  end
end