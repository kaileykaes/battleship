require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/game"

     
  game = Game.new

  puts game.start_game

loop do  
  #setup
  game.robo_place_ship
  puts ''
  puts "It's your turn. You need to lay out your two ships."
  puts "The cruiser is three units long, and the submarine is two units long"
  puts game.human_board.render(true)
  puts 'Choose your squares for the Cruiser (3 spaces):'
  game.human_place_ship(game.human_cruiser)
  puts 'Choose your squares for the Submarine (2 spaces):'
  puts game.human_place_ship(game.human_submarine)

  #turn
  until game.game_over?
  puts game.display_boards
  puts "Enter the coordinate for your shot"
  coordinate = gets.chomp.upcase
    until game.valid_shot?(coordinate)
      game.human_shot_validation(coordinate)
      coordinate = gets.chomp.upcase
      break
      game.human_shoot(coordinate)
    end
  puts game.robo_shoot
  end
  game.winner
  puts game.end_game
  game.bye_bye
end


