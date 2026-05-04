require 'ruby2d' 
require_relative 'player.rb'
require_relative 'map.rb'
require_relative 'falling_block.rb'


set fps_cap: 60

@player = Player.new()

@map = Map.new()

$screen_width = @map.maps[@map.current_map][0].length * Map::SQUARE_SIZE
$screen_height = @map.maps[@map.current_map].length * Map::SQUARE_SIZE

set width: $screen_width, height: $screen_height
p $screen_width, $screen_height


on :key_held do |event|
  #if event.key == 'w'
    #@player.y_speed = - Player::SPEED
  if event.key == 'a'
    @player.x_speed = - Player::SPEED
  #elsif event.key == 's'
    #@player.y_speed = Player::SPEED
  elsif event.key == 'd'
    @player.x_speed = Player::SPEED
  elsif event.key == "space" #|| event.key == "w"
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
  #if event.key == 'w'|| event.key == 's'
    #@player.y_speed = 0
  if event.key == 'a' || event.key == 'd'
    @player.x_speed = 0
  end
end

update do
  @player.update(@map)
  @map.update(@player)
  #puts "player x: #{@player.x} y: #{@player.y}"
  #puts "player speed x: #{@player.x_speed} y: #{@player.y_speed}"
end

show