require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
  end
  
  describe '#initialize' do 
    it 'exists' do
      expect(@board).to be_a Board
    end

    it 'has attributes' do 
      expect(@board.cells).to be_a Hash
      expect(@board.cells.size).to eq(16)
      expect(@board.cells['A1'].class).to eq(Cell)
      expect(@board.cells['B2'].class).to eq(Cell)
      expect(@board.cells['C3'].class).to eq(Cell)
      expect(@board.cells['D4'].class).to eq(Cell)
    end
  end

  describe 'coordinate validation' do 
    it '#valid_coordinate' do 
      expect(@board.valid_coordinate?("A1")).to be true
      expect(@board.valid_coordinate?("D4")).to be true
      expect(@board.valid_coordinate?("A5")).to be false
      expect(@board.valid_coordinate?("E1")).to be false
      expect(@board.valid_coordinate?("A22")).to be  false
    end
  end
end