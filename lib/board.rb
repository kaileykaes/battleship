class Board
  attr_reader :cells

  def initialize
    @ships = []
    @cells = {
          "A1" => Cell.new("A1"),
          "A2" => Cell.new("A2"),
          "A3" => Cell.new("A3"),
          "A4" => Cell.new("A4"),
          "B1" => Cell.new("B1"),
          "B2" => Cell.new("B2"),
          "B3" => Cell.new("B3"),
          "B4" => Cell.new("B4"),
          "C1" => Cell.new("C1"),
          "C2" => Cell.new("C2"),
          "C3" => Cell.new("C3"),
          "C4" => Cell.new("C4"),
          "D1" => Cell.new("D1"),
          "D2" => Cell.new("D2"),
          "D3" => Cell.new("D3"),
          "D4" => Cell.new("D4")
        }
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    ship.length == coordinates.length && are_consecutive?(coordinates) && ship_present?(coordinates) == false
  end

  def place(ship, coordinates)
    coordinates.map do |coordinate|
      if @cells.keys.include?(coordinate)
        @cells[coordinate].place_ship(ship)
      end
    end
  end

  def are_consecutive?(coordinates)
    letters = coordinates.map do |coordinate|
      coordinate[0]
    end
    letter_sameness = letters.all? do |letter|
      letter == coordinates[0][0]
    end
    numbers = coordinates.map do |coordinate|
      coordinate[1].to_i
    end
    number_sameness = numbers.all? do |number|
      number == numbers[1]
    end
    letter_range = (letters.first..letters.last).to_a
    number_range = (numbers.first..numbers.last).to_a
    if letter_sameness == true && number_range == numbers
      true
    elsif letter_sameness == false && letter_range == letters && number_sameness == true
      true
    else
      false
    end
  end

  def ship_present?(coordinates)
    thar_she_blows = coordinates.find do |coordinate| 
      @cells[coordinate].ship != nil
    end
    thar_she_blows == nil ? false : true
  end

  def render(reveal_ship = false)
    if reveal_ship == true
      "  1 2 3 4 \n" +
      "A #{@cells["A1"].render(true)} #{@cells["A2"].render(true)} #{@cells["A3"].render(true)} #{@cells["A4"].render(true)} \n" +
      "B #{@cells["B1"].render(true)} #{@cells["B2"].render(true)} #{@cells["B3"].render(true)} #{@cells["B4"].render(true)} \n" +
      "C #{@cells["C1"].render(true)} #{@cells["C2"].render(true)} #{@cells["C3"].render(true)} #{@cells["C4"].render(true)} \n" +
      "D #{@cells["D1"].render(true)} #{@cells["D2"].render(true)} #{@cells["D3"].render(true)} #{@cells["D4"].render(true)} \n" 
    else
      "  1 2 3 4 \n" +
      "A #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render} \n" +
      "B #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render} \n" +
      "C #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render} \n" +
      "D #{@cells["D1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render} \n" 
    end
  end
end

