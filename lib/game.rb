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
    puts main_menu
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
    print 'My ships are now on my board'
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
    @human_board.render(true)
  end
  
  def display_boards
    "=============ROBO BOARD=============\n" + 
    "#{@robo_board.render}\n" +
    "=============HUMAN BOARD=============\n" +
    "#{@human_board.render(reveal_ship = true)}"
  end
  
  def human_shoot(coordinate)
    @robo_board.cells[coordinate].fire_upon if valid_shot?(coordinate)
    # puts results(@robo_board, coordinate)
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
    # puts results(@human_board, coordinate)
    "#{results(@human_board, coordinate)} declares Robo"
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
  
  def valid_shot?(coordinate)
    if unfired_cells(@robo_board).include?(coordinate) && 
      @robo_board.valid_coordinate?(coordinate) && 
      unfired_cells(@robo_board).include?(coordinate)
      true
    else
      false
    end
  end

  def results(board, coordinate)
    if board.valid_coordinate?(coordinate)
      if board.cells[coordinate].render == 'M'
        puts 'Whoops. Missed.'
        'Whoops. Missed.'
      elsif board.cells[coordinate].render == 'X'
        puts 'Sunken ship!'
        'Sunken ship!'
      elsif board.cells[coordinate].render == 'H'
        puts 'Yippee!! Ship struck!'
        'Yippee!! Ship struck!'
      end
    else
      false
    end
  end

  def setup
    game.robo_place_ship
    puts ''
    puts "It's your turn. You need to lay out your two ships."
    puts "The cruiser is three units long, and the submarine is two units long"
    puts game.human_board.render(true)
    puts 'Choose your squares for the Cruiser (3 spaces):'
    game.human_place_ship(game.human_cruiser)
    puts 'Choose your squares for the Submarine (2 spaces):'
    puts game.human_place_ship(game.human_submarine)
  end
end