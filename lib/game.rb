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
      3.times do 
      random_coordinates << @robo_board.cells.keys.sample
      end
      if @robo_board.valid_placement?(@robo_cruiser, random_coordinates)
        @robo_board.place(@robo_cruiser, random_coordinates)
        break
      end
    end
    loop do
      random_coordinates = []
      2.times do 
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

  def display_boards
    "=============ROBO BOARD=============\n" + 
    "#{@robo_board.render}\n" +
    "=============HUMAN BOARD=============\n" +
    "#{@human_board.render(reveal_ship = true)}"
  end

  def human_shoot(coordinate)
    @robo_board.cells[coordinate].fire_upon if human_shot_validation(coordinate) == 'KABOOM'
    print results(@robo_board, coordinate)
  end

  #helpers
  def unfired_cells(board)
    unfired = board.cells.select do |_, cell|
      cell.fired_upon? == false
    end
    unfired.keys
  end

  def human_shot_validation(coordinate)
    if unfired_cells(@robo_board).include?(coordinate) && @robo_board.valid_coordinate?(coordinate)
      'KABOOM'
    elsif !unfired_cells(@robo_board).include?(coordinate) && @robo_board.valid_coordinate?(coordinate)
      'You already shot there, remember? Try again.'
    elsif !@robo_board.valid_coordinate?(coordinate)
      'No. Check your aim. Set another coordinate in your sights.'
    end
  end

  def results(board, coordinate)
    if board.valid_coordinate?(coordinate)
      if board.cells[coordinate].render == 'M'
        'Whoops. Missed.'
      elsif board.cells[coordinate].render == 'X'
        'Sunken ship!'
      elsif board.cells[coordinate].render == 'H'
        'Yippee!! Ship struck!'
      end
    else
      false
    end
  end
end