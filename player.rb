class Player
  SIZE = 25
  START_POS_X = 10
  START_POS_Y = 20
  COLOR = 'blue'
  SPEED = 3.5
  GRAVITY = 0.5
  JUMP_STRENGTH = 11

  attr_accessor :x_speed, :y_speed, :hitbox , :x, :y, :can_jump
  def initialize()
    @x_speed = 0
    @y_speed = 0
    @x = START_POS_X
    @y = START_POS_Y
    @can_jump = false
    @hitbox = Square.new(x: START_POS_X, y: START_POS_Y, size: SIZE, color: COLOR, z: 10)
  end

  def update(blocks)
    @x += @x_speed
    handle_collisions(blocks, "horizontal")

    #@y += @y_speed
    gravity()
    jump_state(blocks)
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
    if @can_jump
      @y_speed = - JUMP_STRENGTH
      #puts "jumping"
    end
  end

  def jump_state(blocks)
    @can_jump = false
    blocks.each do |block|
      if check_collisions(block, "vertical") == "hit top" || check_collisions(block, "vertical") == "hit bottom"
        return @can_jump = true    
      end
    end
  end

      

  def collided_with(block)
    result = @x + SIZE > block.x &&
            @x < block.x + block.width &&
            @y + SIZE > block.y &&
            @y < block.y + block.height
    return result
  end
end 