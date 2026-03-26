require 'ruby2d' 
require_relative 'player.rb'
require_relative 'block.rb'


set fps_cap: 60

@player = Player.new()

block = Block.new(0, 300, 500, 150, 'red')


on :key_held do |event|
  #if event.key == 'w'
    #@player.y_speed = - Player::SPEED
  if event.key == 'a'
    @player.x_speed = - Player::SPEED
  #elsif event.key == 's'
    #@player.y_speed = Player::SPEED
  elsif event.key == 'd'
    @player.x_speed = Player::SPEED
  elsif event.key == "space"
    if @player.can_jump == true
      @player.jump
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
  @player.update(block)
  #puts "player x: #{@player.x} y: #{@player.y}"
  #puts "player speed x: #{@player.x_speed} y: #{@player.y_speed}"
end

show