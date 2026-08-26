class Enemy
    SIZE = 16
    COLOR = 'red'
    SPEED = 2
    GRAVITY = Game::GRAVITY
    def initialize(start_pos_x, start_pos_y)
        @x_speed = -SPEED
        @y_speed = 0
        @x = start_pos_x
        @y = start_pos_y
        @hitbox = Square.new(x: start_pos_x, y: start_pos_y, size: SIZE, color: COLOR, z: 10)
    end

    def update(map)
        @hitbox.x = @x
        @hitbox.y = @y
        @x += @x_speed
        movement()
        handle_collisions(map, "horizontal")
        gravity()
        handle_collisions(map, "vertical")
    end

    #Finds which side of a block was hit
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

  #Handles collisions for a specific direction 
  def handle_collisions(map, direction)
    handle_block_collisions(map.blocks, direction)
  end

  #Handles collisions with all blocks in the current map.
  def handle_block_collisions(blocks_hash, direction)
    blocks_hash.each_value do |blocks|
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
  end
          
  def gravity()
    @y_speed += GRAVITY
    @y += @y_speed
  end

  #Checks if enemy has collided with a block.
  def collided_with(block)
    result = @x + SIZE > block.x &&
            @x < block.x + block.width &&
            @y + SIZE > block.y &&
            @y < block.y + block.height
    return result
  end

  #Returns which side of the screen the enemy has exited.
  def outside_screen_position()
    player_right_side = @x + SIZE
    right_wall = $screen_width
    player_left_side = @x
    left_wall = 0

    if player_right_side > right_wall
      return "right"
    elsif player_left_side < left_wall
      return "left"
    end
  end

  #Checks if enemy is outside the screen.
  def outside_screen?()
    if @x < 0 || @x - SIZE > $screen_width
      return true
    else 
      return false
    end
  end

  def movement()
    if 
end

