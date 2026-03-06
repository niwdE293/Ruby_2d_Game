require 'ruby2d'

@player = Square.new(x: 10, y: 20, size: 25, color: 'blue')
@player_speed = 3

@x_speed = 0
@y_speed = 0

set fps_cap: 60

@rectangle = Rectangle.new(x: (get :width) / 2, y: (get :height) / 2, width: 200, height: 20, color: 'white')

on :key_held do |event|
  if event.key == 'w'
    @y_speed = - @player_speed
  elsif event.key == 'a'
    @x_speed = - @player_speed
  elsif event.key == 's'
    @y_speed = @player_speed
  elsif event.key == 'd'
    @x_speed = @player_speed
  end
end

on :key_up do |event|
  if event.key == 'w'|| event.key == 's'
    @y_speed = 0
  elsif event.key == 'a' || event.key == 'd'
    @x_speed = 0
  end
end

update do
  @player.x += @x_speed
  @player.y += @y_speed
end

if @player


show