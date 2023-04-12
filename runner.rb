require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/game"

game = Game.new

puts game.main_menu
gets.chomp

puts game.human_place_ship
gets.chomp