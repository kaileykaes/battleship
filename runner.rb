require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/game"

game = Game.new
puts game.start_game

loop do  
  game.main_menu
  game.start_game
  game.setup 
  game.turn
  game.winner
  puts game.end_game
  game.bye_bye
end


