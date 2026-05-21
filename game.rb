class Game 
    GRAVITY = 0.5
    attr_accessor :player, :map
    def initialize()
        @player = Player.new()
        @map = Map.new()
    end

    def update()
        @player.update(@map)
        @map.update(@player)
        update_falling_blocks()
        #p "player y: #{@player.y + Player::SIZE}"
    end

    #Calculates screen width based on map and square size.
    def calculate_screen_width()
        width = @map.maps[@map.current_map][0].length * Map::SQUARE_SIZE  
        return width
    end

     #Calculates screen height based on map and square size.
    def calculate_screen_height()
        height = @map.maps[@map.current_map].length * Map::SQUARE_SIZE
        return height
    end

        #Updates all falling blocks in the current map.
    def update_falling_blocks()
        @map.blocks["falling_blocks"].each do |falling_block|
            falling_block.update(@player, @map)
        end
    end
end