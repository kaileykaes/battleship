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

  def start_game
    main_menu
    loop do 
      input = gets.chomp
      if input == "p" 
        break 
      elsif input == "q"
        puts "See you later"     
      else
        puts "I don't understand. Enter p or q"
      end
    end
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
  end
  
  def human_place_ship(ship)
    loop do
      human_input = gets.chomp.upcase.split(" ")
      if @human_board.valid_placement?(ship, human_input)
        @human_board.place(ship, human_input)
        break
      else
        puts "Try again with valid coordinates:\n "
      end
    end  
    puts @human_board.render(true)
  end
  
  def display_boards
    "=============ROBO BOARD=============\n" + 
    "#{@robo_board.render}\n" +
    "=============HUMAN BOARD=============\n" +
    "#{@human_board.render(reveal_ship = true)}"
  end
  
  def human_shoot(coordinate)
    @robo_board.cells[coordinate].fire_upon if human_shot_validation(coordinate) == 'KABOOM'
    results(@robo_board, coordinate)
  end
  
  def robo_shoot
    coordinate = @human_board.cells.keys.sample
    until unfired_cells(@human_board).include?(coordinate) &&
      @human_board.valid_coordinate?(coordinate)
      coordinate = @human_board.cells.keys.sample
      break
    end
    @human_board.cells[coordinate].fire_upon
    results(@human_board, coordinate)
  end
  
  def game_over?
    if @human_cruiser.sunk? && @human_submarine.sunk?
      true
    elsif @robo_cruiser.sunk? && @robo_submarine.sunk?
      true
    else
      false
    end
  end
  
  def winner 
    if game_over?
      if @human_cruiser.sunk? && @human_submarine.sunk?
        :robo
      elsif @robo_cruiser.sunk? && @robo_submarine.sunk?
        :human
      end
    else 
      :nobody
    end
  end
  
  def end_game
    if game_over?
      if winner == :robo
        'Robo wins!'
      elsif winner == :human
        'You win!'
      end
    end
  end
  
  def bye_bye
    puts

    puts "                The battle is over... for now...                               "
    main_menu
  end

  #helpers

  def unfired_cells(board)
    unfired = board.cells.select do |_, cell|
      cell.fired_upon? == false
    end
    unfired.keys
  end
  
  #helpers
  def unfired_cells(board)
    unfired = board.cells.select do |_, cell|
      cell.fired_upon? == false
    end
    unfired.keys
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