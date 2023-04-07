require './lib/ship'

Rspec.describe Ship do
  it 'exists' do
    cruiser = Ship.new("Cruiser", 3)
    expect(cruiser).to be_an_instance_of(Ship)
  end

  it 'has attributes' do
    cruiser = Ship.new("Cruiser", 3)
    expect(cruiser.name).to eq("Cruiser")
    expect(cruiser.length).to eq(3)
    expect(cruiser.health).to eq(3)
    expect(cruiser.sunk?).to eq(false)
  end

  it 'can take hits and sink' do
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    expect(cruiser.health).to eq(2)
    cruiser.hit
    expect(cruiser.health).to eq(1)
    cruiser.hit
    expect(cruiser.health).to eq(0)
  end

  it 'can sink' do
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    cruiser.hit
    cruiser.hit
    expect(sunk?).to eq(true)
  end

end