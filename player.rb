class Player
  SIZE = 20
  START_POS_X = 10
  START_POS_Y = 20
  COLOR = 'blue'
  SPEED = 3.5
  GRAVITY = Game::GRAVITY
  JUMP_STRENGTH = 11

  attr_accessor :x_speed, :y_speed, :hitbox , :x, :y, :can_jump, :can_grab, :grab_y, :grabing, :lives
  def initialize()
    @x_speed = 0
    @y_speed = 0
    @x = START_POS_X
    @y = START_POS_Y
    @can_jump = false
    @can_grab = false
    @width = SIZE
    @height = SIZE
    @grab_y = 0
    @grabing = false
    @hitbox = Square.new(x: START_POS_X, y: START_POS_Y, size: SIZE, color: COLOR, z: 10)
    @lives = 3
  end

  def update(map)
    @hitbox.x = @x
    @hitbox.y = @y
    @x += @x_speed
    handle_collisions(map, "horizontal")

    gravity()
    jump_state(map.blocks)
    grab_state(map.blocks)
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

  def jump()
    @y_speed = - JUMP_STRENGTH
  end

  #Determines if the player can jump.
  def jump_state(block_keys)
    @can_jump = false
    block_keys.each_value do |blocks|
      blocks.each do |block|
        if check_collisions(block, "vertical") == "hit top" 
          return @can_jump = true    
        end
      end
    end
  end

  #Determines if the player can grab.
  def grab_state(block_keys)
    @can_grab = false
    block_keys.each_value do |blocks|
      blocks.each do |block|
        if check_collisions(block, "vertical") == "hit bottom"
          @grab_y = block.y + Map::SQUARE_SIZE
          @can_grab = true 
        end
      end
    end
  end

  def grab()
    @y_speed = - GRAVITY - 0.01 
    @y = @grab_y
  end

  #Checks if player has collided with a block.
  def collided_with(block)
    result = @x + SIZE > block.x &&
            @x < block.x + block.width &&
            @y + SIZE > block.y &&
            @y < block.y + block.height
    return result
  end

  #Returns which side of the screen the player has exited.
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

  #Returns which side of the screen the center of player has exited.
  def center_outside_screen_position()
    player_center = @x + (SIZE / 2)     
    right_wall = $screen_width
    left_wall = 0

    if player_center > right_wall
      return "right"
    elsif player_center < left_wall
      return "left"
    end
  end

  #Checks if player is outside the screen.
  def outside_screen?()
    if @x < 0 || @x - SIZE > $screen_width
      return true
    else 
      return false
    end
  end

  #Updates the text for current lives.
  def display_lives()
    if @lives_text != nil
      @lives_text.remove
    end
    @lives_text = Text.new("Lives: #{@lives}", x: 20, y: 20, style: 'bold', size: 20, color: 'red')
  end
end 