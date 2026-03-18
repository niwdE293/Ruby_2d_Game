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
    @hitbox = Square.new(x: START_POS_X, y: START_POS_Y, size: SIZE, color: COLOR, z: 10)
  end

  def update()
    @hitbox.x += @x_speed
    @hitbox.y += @y_speed
    @x += @x_speed
    @y += @y_speed
    
  end

  def collided_with(x, y, width, height)
      if @x + SIZE >= x &&  # Left edge
        @x <= x + width &&  # Right edge
        @y + SIZE >= y &&   # Top edge
        @y <= y + height    # Bottom edge 
        puts "colided"
        return true
      else
        return false
      end
  end
end 



class Block
  attr_accessor :x , :y, :width, :height, :color
  def initialize(x, y, width, height, color)
    @x = x
    @y = y 
    @width = width
    @height = height
    @block = Rectangle.new(x: x, y: y, width: width, height: height, color: color, z: 0)
  end
end


set fps_cap: 60

@player = Player.new()

@block = Block.new(400, 300, 150, 150, 'red')


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
  
  if @player.collided_with(@block.x, @block.y, @block.width, @block.height)
    #Left edge
    if @player.x_speed > 0
      puts "hit left"
      @player.x -= 3
      @player.hitbox.x -= 3
      
    #Right edge
    elsif @player.x_speed < 0
      puts "hit right"
      @player.x += 3
      @player.hitbox.x += 3
    
    #Top edge
    elsif @player.y_speed > 0
      puts "hit top"
      @player.y -= 3
      @player.hitbox.y -= 3

    #Bottom edge  
    elsif @player.y_speed < 0
      puts "hit bottom"
      @player.y += 3
      @player.hitbox.y -= 3
    end
  else 
    @player.update
  end
  #puts "player x: #{@player.x} y: #{@player.y}"
  #puts "player speed x: #{@player.x_speed} y: #{@player.y_speed}"
end

show