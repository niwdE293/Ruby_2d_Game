require_relative 'main'

class Player
  SIZE = 25
  START_POS_X = 10
  START_POS_Y = 20
  COLOR = 'blue'
  SPEED = 3.5
  GRAVITY = 0.5
  JUMP_STRENGTH = 11

  attr_accessor :x_speed, :y_speed, :hitbox , :x, :y, :can_jump, :can_grab, :grab_y, :grabing
  def initialize()
    @x_speed = 0
    @y_speed = 0
    @x = START_POS_X
    @y = START_POS_Y
    @can_jump = false
    @can_grab = false
    @grab_y = 0
    @grabing = false
    @hitbox = Square.new(x: START_POS_X, y: START_POS_Y, size: SIZE, color: COLOR, z: 10)
  end

  def update(blocks)
    @x += @x_speed
    handle_collisions(blocks, "horizontal")

    #@y += @y_speed
    gravity()
    jump_state(blocks)
    grab_state(blocks)
    handle_collisions(blocks, "vertical")

    @hitbox.x = @x
    @hitbox.y = @y
  end


  def check_collisions(block, direction)
    if collided_with(block)
      if direction == "horizontal"
        #Left edge
        if @x_speed > 0 && @x <= block.x + (block.width / 2)
          return "hit left"
        #Right edge
        elsif @x_speed < 0 && @x >= block.x + (block.width / 2) 
          return "hit right"
        end
      
      elsif direction == "vertical"
        #Top edge
        if @y_speed > 0 && @y <= block.y + (block.height / 2)
          return "hit top"
        #Bottom edge  
        elsif @y_speed < 0 && @y >=  block.y + (block.height / 2) 
          return "hit bottom"
        end
      end
    end
  end


  def handle_collisions(blocks, direction)
    blocks.each do |block|
      if check_collisions(block, direction) == "hit left"
        @x = block.x - SIZE 
      elsif check_collisions(block, direction) == "hit right"
        @x = block.x + block.width
      elsif check_collisions(block, direction) == "hit top"
        @y = block.y - SIZE
        @y_speed = 0
      elsif check_collisions(block, direction) == "hit bottom"
        @y = block.y + block.height
        @y_speed = 0
      end
    end
  end


  def gravity()
    @y_speed += GRAVITY
    @y += @y_speed
  end

  def jump()
    @y_speed = - JUMP_STRENGTH
    #puts "jumping"
  end

  def jump_state(blocks)
    @can_jump = false
    blocks.each do |block|
      if check_collisions(block, "vertical") == "hit top" #|| check_collisions(block, "vertical") == "hit bottom"
        return @can_jump = true    
      end
    end
  end

  def grab_state(blocks)
    @can_grab = false
    blocks.each do |block|
      if check_collisions(block, "vertical") == "hit bottom"
        @grab_y = block.y + Map::SQUARE_SIZE
        @can_grab = true 
        return
      end
    end
  end

  def grab()
    @y_speed = - GRAVITY - 0.1
    @y = @grab_y
  end

  def collided_with(block)
    result = @x + SIZE > block.x &&
            @x < block.x + block.width &&
            @y + SIZE > block.y &&
            @y < block.y + block.height
    return result
  end

  def outside_map_position()
    player_right_side = @x + SIZE
    right_wall = screen_width
    player_left_side = @x
    left_wall = 0

    if player_right_side > right_wall
      return "right"
    elsif player_left_side < left_wall
      return "left"
    end
  end
end 