require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/game"

     
  game = Game.new

  puts game.start_game

loop do  
  #setup
  game.setup 
  
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


