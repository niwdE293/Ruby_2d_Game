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
    if collided_with(block)
      #Left edge
      if direction == "horizontal"
        if @x_speed > 0 && @x <=  block.x + (block.width / 2)
          puts "hit left"
          @x = block.x - SIZE 
          
        #Right edge
        elsif @x_speed < 0 && @x >= block.x + (block.width / 2) 
          puts "hit right"
          @x = block.x + block.width
        end
      
      elsif direction == "vertical"
        #Top edge
        if @y_speed > 0 && @y <= block.y + (block.height / 2) 
          puts "hit top"
          @y = block.y - SIZE
          @y_speed = 0

        #Bottom edge  
        elsif @y_speed < 0 && @y >=  block.y + (block.height / 2) 
          puts "hit bottom"
          @y = block.y + block.height
          @y_speed = 0
        end
      end
    end
  end


  def gravity(block)
    @y_speed += GRAVITY
    @y += @y_speed
  end


  def collided_with(block)
    result = @x + SIZE > block.x &&
            @x < block.x + block.width &&
            @y + SIZE > block.y &&
            @y < block.y + block.height

    puts "collided check result: #{result}"
    return result
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