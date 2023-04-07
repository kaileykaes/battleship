class Cell

  attr_reader :ship, 
              :coordinate
  
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
    if fired_upon? && empty?
      "M"
    elsif fired_upon? && @ship.sunk?
      "X"
    elsif @is_fired_upon && @ship
      "H"
    elsif reveal_ship && !empty?
      "S"
    else
      '.'
    end
  end
end