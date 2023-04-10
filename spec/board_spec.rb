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

  describe 'placment validation' do
    it 'checks before ship placement' do
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])). to be false
    end
  
    it 'has consecutive coordinates' do
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be false
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to be false
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be false
      expect(board.valid_placement?(submarine, ["C1", "B1"])).to be false
    end
  
    it 'is not diagonal' do
      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be false
      expect(board.valid_placement?(submarine, ["C2", "D3"])).to be false
    end

    it '#valid_placement' do
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to be true
      expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be true
    end
  end
end