require 'ruby2d' 
require_relative 'game.rb'
require_relative 'player.rb'
require_relative 'map.rb'
require_relative 'falling_block.rb'


set fps_cap: 60

@game = Game.new()

$screen_width = @game.calculate_screen_width  
$screen_height = @game.calculate_screen_height 

set width: $screen_width, height: $screen_height
#p $screen_width, $screen_height


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