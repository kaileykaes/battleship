require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/game"

game = Game.new

puts game.human_place_ship(game.human_cruiser)
gets.chomp

puts game.human_place_ship(game.human_submarine)
gets.chomp


puts game.main_menu
gets.chomp


