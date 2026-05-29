class Falling_block
    SIZE = Map::SQUARE_SIZE
    COLOR = 'red'
    FALL_MARGIN = 2 * SIZE
    GRAVITY = Game::GRAVITY

    attr_accessor :x, :y, :x_speed, :y_speed, :falling
    def initialize(x, y, map, id)
        @tile_info = get_tile_info()
        @hitbox = Sprite.new('map/Tileset.png', x: x*SIZE, y: y*SIZE, width: 16, height: 16, clip_width: 16, clip_height: 16, clip_x: @tile_info[id]["x"] * SIZE, clip_y: @tile_info[id]["y"] * SIZE) #Image.new(img, x: x, y: y, width: SIZE, height: SIZE)
        @x = x
        @y = y
        @x_speed = 0
        @y_speed = 0
        @falling = false
        @hit_ground = false
        @map = map
        @width = SIZE
        @height = SIZE
    end

    def update(player, map)
        @hitbox.x = @x
        @hitbox.y = @y
        handle_fall(player, map.blocks)
        handle_ground_collisions()
    end

    #Handles when the block falls and collisions with player.
    def handle_fall(player, block_types)
        block_center = @x + SIZE / 2
        if @falling 
            if fell_on(player) 
                remove()
                player.lives -= 1
                player.display_lives()
            else
                gravity()
            end
        elsif within_fall_margin?(player)
            if @falling == false   
                fall()
            end
        end
        @y += @y_speed
    end

    def fall()
        @falling = true
        @y_speed += GRAVITY
    end

    #Checks if player is close enough to the falling block to trigger it's fall.
    def within_fall_margin?(player)
        block_center = @x + SIZE / 2
        if player.x < block_center + FALL_MARGIN && player.x > block_center - FALL_MARGIN
            return true
        end
        return false
    end

    #Stops the block when it hits the ground.
    def handle_ground_collisions()
        #p "y: #{@y + SIZE}"
        if hit_ground?()
            #p "hit ground"
            #remove()
            @y_speed =  0
            @map.blocks["ground"].each do |ground_block|
                if collided_with(ground_block)
                    @y = ground_block.y - SIZE
                end
            end
        end
    end

    #Checks if the block has collided with a ground block
    def hit_ground?()
        @map.blocks["ground"].each do |ground_block|
            if collided_with(ground_block)
                return true
            end
        end
        return false
    end

    #Takes in a block and checks if self has collided with a block.
    def collided_with(block)
        result = @x + SIZE > block.x && 
                @x < block.x + block.width &&
                @y + SIZE > block.y && 
                @y < block.y + block.height 
        return result
    end 

    def gravity()
        @y_speed += GRAVITY
    end

    #Removes the block from the screen and array.
    def remove()
        p "Removing a falling block"
        @hitbox.remove
        @map.remove_falling_block(self)
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

    #Checks if the block has landed on top of a object.
    def fell_on(object)
        if check_collisions(object, "vertical") == "hit top" 
            return true
        end
        return false
    end
end