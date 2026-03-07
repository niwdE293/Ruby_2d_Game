require 'ruby2d'

class Player
  SIZE = 25
  START_POS_X = 10
  START_POS_Y = 20
  COLOR = 'blue'
  SPEED = 3

  attr_accessor :x_speed, :y_speed, :hitbox , :x, :y
  def initialize()
    @x_speed = 0
    @y_speed = 0
    @x = START_POS_X
    @y = START_POS_Y
    @hitbox = Square.new(x: START_POS_X, y: START_POS_Y, size: SIZE, color: COLOR)
  end

  def update()
    @hitbox.x += @x_speed
    @hitbox.y += @y_speed
  end

  def collided()
    if (r1x + r1w >= r2x &&    // r1 right edge past r2 left
      r1x <= r2x + r2w &&    // r1 left edge past r2 right
      r1y + r1h >= r2y &&    // r1 top edge past r2 bottom
      r1y <= r2y + r2h) {    // r1 bottom edge past r2 top
        return true;
  }
  return false;
}
  end
end



class Object
  attr_accessor :x , :y, :width, :height, :color
  def initialize(x, y, width, height, color)
    @object = Rectangle.new(x: x, y: y, width: width, height: height, color: color)
  end
end


set fps_cap: 60

@player = Player.new()

@object = Object.new(400, 300, 100, 10, 'blue')


on :key_held do |event|
  if event.key == 'w'
    @player.y_speed = - Player::SPEED
  elsif event.key == 'a'
    @player.x_speed = - Player::SPEED
  elsif event.key == 's'
    @player.y_speed = Player::SPEED
  elsif event.key == 'd'
    @player.x_speed = Player::SPEED
  end
end

on :key_up do |event|
  if event.key == 'w'|| event.key == 's'
    @player.y_speed = 0
  elsif event.key == 'a' || event.key == 'd'
    @player.x_speed = 0
  end
end

update do
  @player.update
end

show