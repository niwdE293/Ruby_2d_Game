require 'ruby2d' 
require_relative 'player.rb'
require_relative 'map.rb'
require_relative 'falling_block.rb'


set fps_cap: 60

@player = Player.new()

@map = Map.new()

#Calculates screen height and wisth based on map and square size.
$screen_width = @map.maps[@map.current_map][0].length * Map::SQUARE_SIZE
$screen_height = @map.maps[@map.current_map].length * Map::SQUARE_SIZE

set width: $screen_width, height: $screen_height
p $screen_width, $screen_height


on :key_held do |event|
  if event.key == 'a'
    @player.x_speed = - Player::SPEED
  elsif event.key == 'd'
    @player.x_speed = Player::SPEED
  elsif event.key == "space" 
    if @player.can_jump 
      @player.jump
    end
  elsif event.key == "w"
    if @player.can_grab 
      @player.grab
      @player.grabing = true
    else 
      @player.grabing = false
    end
  end
end

on :key_up do |event|
  if event.key == 'a' || event.key == 'd'
    @player.x_speed = 0
  end
end

update do
  @player.update(@map)
  @map.update(@player)
end

show