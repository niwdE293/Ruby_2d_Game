class Falling_block
    SIZE = Map::SQUARE_SIZE
    COLOR = 'red'
    FALL_MARGIN = 2 * SIZE
    GRAVITY = Player::GRAVITY

    attr_accessor :x, :y, :x_speed, :y_speed, :falling
    def initialize(x, y, map)
        @hitbox = Square.new(x: x, y: y, size: SIZE, color: COLOR)
        @x = x
        @y = y
        @x_speed = 0
        @y_speed = 0
        @falling = false
        @map = map
        @width = SIZE
        @height = SIZE
    end

    def update(player)
        @hitbox.x = @x
        @hitbox.y = @y
        handle_fall(player)
        handle_ground_collisions()
    end

    def handle_fall(player)
        block_center = @x + SIZE / 2
        if @falling 
            if fell_on(player)
                remove()
                player.lives -= 1
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

    def within_fall_margin?(player)
        block_center = @x + SIZE / 2
        if player.x < block_center + FALL_MARGIN && player.x > block_center - FALL_MARGIN
            return true
        end
        return false
    end

    def handle_ground_collisions()
        if hit_ground?()
            @y_speed =  0
            @map.blocks["ground"].each do |ground_block|
                if collided_with(ground_block)
                    @y = ground_block.y - SIZE
                end
            end
        end
    end

    def hit_ground?()
        @map.blocks["ground"].each do |ground_block|
            if collided_with(ground_block)
                return true
            end
        end
        return false
    end

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

    def remove()
        @hitbox.remove
        @map.remove_block(self)
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


    def fell_on(player)
        if check_collisions(player, "vertical") == "hit top" 
            return true
        end
        return false
    end
end