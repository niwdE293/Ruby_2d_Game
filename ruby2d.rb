require 'ruby2d'

class Player
  SIZE = 25
  START_POS_X = 10
  START_POS_Y = 20
  COLOR = 'blue'
  SPEED = 3
  GRAVITY = 0.2

  attr_accessor :x_speed, :y_speed, :hitbox , :x, :y
  def initialize()
    @x_speed = 0
    @y_speed = 0
    @x = START_POS_X
    @y = START_POS_Y
    @hitbox = Square.new(x: START_POS_X, y: START_POS_Y, size: SIZE, color: COLOR, z: 10)
  end

  def update(blocks)
    @x += @x_speed
    check_collisions(blocks, "horizontal")

    #@y += @y_speed

    gravity(blocks)
    check_collisions(blocks, "vertical")

    @hitbox.x = @x
    @hitbox.y = @y
  end

  def check_collisions(block, direction)
    p collided_with(block.x, block.y, block.width, block.height)
    if collided_with(block.x, block.y, block.width, block.height)
      #Left edge
      if direction == "horizontal"
        if @x_speed > 0 && @x <=  block.x + (block.width / 2)
          puts "hit left"
          @x = block.x - Player::SIZE 
          
        #Right edge
        elsif @x_speed < 0 && @x >= block.x + (block.width / 2) 
          puts "hit right"
          @x = block.x + block.width
        end
      
      elsif direction == "vertical"
        #Top edge
        if @y_speed > 0 && @y <=block.y + (block.height / 2) 
          puts "hit top"
          @y = block.y - Player::SIZE

        #Bottom edge  
        elsif @y_speed < 0 && @y >=  block.y + (block.height / 2) 
          puts "hit bottom"
          @y = block.y + block.height
        end
      end
    end
  end

  def gravity(block)
    #p collided_with(block.x, block.y, block.width, block.height)
    if collided_with(block.x, block.y, block.width, block.height) == true
      puts "reseting player speed"
      @y_speed = 0
    else
      @y_speed += Player::GRAVITY
      @y += @y_speed
    end
  end

  def collided_with(x, y, width, height)
    if @x + SIZE > x &&  # Left edge
        @x < x + width &&  # Right edge
        @y + SIZE > y &&   # Top edge
        @y < y + height    # Bottom edge 
      puts "collided" 
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
    block = Rectangle.new(x: x, y: y, width: width, height: height, color: color, z: 0)
  end
end


set fps_cap: 60

@player = Player.new()

block = Block.new(0, 300, 500, 150, 'red')


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
  @player.update(block)
  #puts "player x: #{@player.x} y: #{@player.y}"
  #puts "player speed x: #{@player.x_speed} y: #{@player.y_speed}"
end

show