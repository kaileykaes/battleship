class Cell
  attr_reader :ship, 
              :coordinate, 
              :is_fired_upon
  
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @is_fired_upon = false 
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @is_fired_upon
  end

  def fire_upon
    if !empty?
        @ship.hit
    end
    @is_fired_upon = true
  end
  
  def render(reveal_ship = false)
    if reveal_ship && !empty? && fired_upon? == false
      "S"
    elsif (reveal_ship || !reveal_ship) && fired_upon? && empty?
      "M" 
    elsif (reveal_ship || !reveal_ship) && fired_upon? && !empty? && @ship.sunk?
      "X"
    elsif (reveal_ship || !reveal_ship) && fired_upon? && !empty? && !@ship.sunk?
      "H"
    elsif (reveal_ship || !reveal_ship) && !fired_upon?
      '.'
    end
  end
end