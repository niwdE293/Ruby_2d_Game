require 'ruby2d' 
require_relative 'player.rb'
require_relative 'map.rb'
require_relative 'falling_block.rb'
require_relative 'game.rb'


set fps_cap: 60

@game = Game.new()

#@player = Player.new()

#@map = Map.new()

#Calculates screen height and width based on map and square size.

$screen_width = @game.calculate_screen_width  #@map.maps[@map.current_map][0].length * Map::SQUARE_SIZE
$screen_height = @game.calculate_screen_height #@map.maps[@map.current_map].length * Map::SQUARE_SIZE

set width: $screen_width, height: $screen_height
p $screen_width, $screen_height


on :key_held do |event|
  if event.key == 'a'
    @game.player.x_speed = - Player::SPEED
  elsif event.key == 'd'
    @game.player.x_speed = Player::SPEED
  elsif event.key == "space" 
    if @game.player.can_jump 
      @game.player.jump
    end
  elsif event.key == "w"
    if @game.player.can_grab 
      @game.player.grab
      @game.player.grabing = true
    else 
      @game.player.grabing = false
    end
  end
end

on :key_up do |event|
  if event.key == 'a' || event.key == 'd'
    @game.player.x_speed = 0
  end
end

update do
  @game.update
end

show