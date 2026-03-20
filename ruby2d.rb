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
  @player.update
  if @player.collided_with(@block.x, @block.y, @block.width, @block.height)
    #Left edge
    if @player.x_speed > 0 && @player.y >=  @block.y && @player.y <= (@block.y + @block.height) 
      puts "hit left"
      @player.x = @block.x - Player::SIZE 
      @player.hitbox.x = @block.x - Player::SIZE 
      
    #Right edge
    elsif @player.x_speed < 0 && @player.y >=  @block.y && @player.y <= (@block.y + @block.height) 
      puts "hit right"
      @player.x = @block.x + @block.width 
      @player.hitbox.x = @block.x + @block.width 
    
    #Top edge
    elsif @player.y_speed > 0 && @player.x >=  @block.x && @player.y <= (@block.x + @block.width) 
      puts "hit top"
      @player.y = @block.y - Player::SIZE
      @player.hitbox.y = @block.y - Player::SIZE  

    #Bottom edge  
    elsif @player.y_speed < 0 && @player.x >=  @block.x && @player.y <= (@block.x + @block.width)
      puts "hit bottom"
      @player.y = @block.y + @block.height
      @player.hitbox.y = @block.y + @block.height 
    end 
  end

  puts "player x: #{@player.x} y: #{@player.y}"
  #puts "player speed x: #{@player.x_speed} y: #{@player.y_speed}"
end

show