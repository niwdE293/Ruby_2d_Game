class Falling_block
    SIZE = Map::SQUARE_SIZE
    COLOR = 'red'
    FALL_MARGIN = 2 * SIZE
    GRAVITY = Player::GRAVITY

    def initialize(x, y, map)
        @hitbox = Square.new(x: x, y: y, size: SIZE, color: COLOR)
        @x = x
        @y = y
        @x_speed = 0
        @y_speed = 0
        @falling = false
        @map = map
    end

    def update(player)
        @hitbox.x = @x
        @hitbox.y = @y
        handle_fall(player)
        handle_ground_collisions()
    end

    def handle_fall(player)
        block_center = @x + SIZE / 2
        if @falling = true
            gravity()
        elsif within_fall_margin?(player.x)
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

    def within_fall_margin?(x)
        if x < block_center + FALL_MARGIN && x > block_center - FALL_MARGIN
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
end