class Game
  attr_reader :human_board,
              :robo_board,
              :robo_cruiser,
              :robo_submarine,
              :human_cruiser,
              :human_submarine

  def initialize
    @human_board = Board.new
    @robo_board = Board.new
    @robo_cruiser = Ship.new("Cruiser", 3)
    @robo_submarine = Ship.new("Submarine", 2)
    @human_cruiser = Ship.new("Cruiser", 3)
    @human_submarine = Ship.new("Submarine", 2)
  end

  def main_menu
    "Welcome to BATTLESHIP\n Enter p to play. Enter q to quit."
  end

  def robo_place_ship
    loop do
      random_coordinates = []
      @robo_cruiser.length.times do 
      random_coordinates << @robo_board.cells.keys.sample
      end
      if @robo_board.valid_placement?(@robo_cruiser, random_coordinates)
        @robo_board.place(@robo_cruiser, random_coordinates)
        break
      end
    end
    loop do
      random_coordinates = []
      @robo_submarine.length.times do 
      random_coordinates << @robo_board.cells.keys.sample
      end
      if @robo_board.valid_placement?(@robo_submarine, random_coordinates)
        @robo_board.place(@robo_submarine, random_coordinates)
          break
      end
    end

    # random_coordinates
    # 2 samples of keys for sub
    # 3 samples of keys for cruiser
  end
  
  def human_ship_placement
    # takes coordinates from player = []
    # place ship
    # if invalid placement, prompts to enter valid placement
  end



end