require 'rspec'
require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each) do
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new('C3')
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe '#initialize' do 
    it 'exists' do
      expect(@cell_1).to be_a Cell
    end

    it 'has attributes' do 
      expect(@cell_1.coordinate).to eq('B4')
      expect(@cell_1.ship).to be nil
    end
  end

  describe 'ship placement' do 
    it 'begins empty' do 
      expect(@cell_1.empty?).to be true
    end

    it '#place_ship' do 
      @cell_1.place_ship(@cruiser)
      expect(@cell_1.ship).to eq(@cruiser)
      expect(@cell_1.empty?).to be false
    end
  end

  describe 'fire' do 
    it '#fired_upon?' do 
      @cell_1.place_ship(@cruiser)
      expect(@cell_1.fired_upon?).to be false
    end
    
    it '#fire_upon' do 
      @cell_1.place_ship(@cruiser)
      @cell_1.fire_upon
      expect(@cell_1.ship.health).to eq(2)
      expect(@cell_1.fired_upon?).to be true
    end
  end

  describe '#render' do 
    it 'begins with .' do 
      expect(@cell_1.render).to eq('.')
    end

    it 'renders M if ship missed' do 
      @cell_1.fire_upon
      expect(@cell_1.render).to eq('M')
    end

    it 'renders S if ship presence is true' do 
      @cell_2.place_ship(@cruiser)
      expect(@cell_2.render).to eq('.')
      expect(@cell_2.render(true)).to eq('S')
    end

    it 'renders H if ship hit' do 
      @cell_2.place_ship(@cruiser)
      @cell_2.fire_upon
      expect(@cell_2.render).to eq('H')
    end

    it 'renders X if ship sunk' do 
      @cell_2.place_ship(@cruiser)
      @cell_2.fire_upon
      @cruiser.hit
      @cruiser.hit
      expect(@cell_2.render).to eq('X')
    end
  end

  describe 'sinkage' do 
    it '#sunk?' do 
      @cell_2.place_ship(@cruiser)
      @cell_2.fire_upon
      expect(@cell_2.sunk?).to be false
    end

    it '#hit' do 
      @cell_2.place_ship(@cruiser)
      @cell_2.fire_upon
      @cruiser.hit
      @cruiser.hit
      expect(@cruiser.sunk?).to be true
    end
  end
end