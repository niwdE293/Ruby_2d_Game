class Game 
    GRAVITY = 0.5
    attr_accessor :player, :map
    def initialize()
        @player = Player.new()
        @map = Map.new()
        @enemy = Enemy.new(300,75)
    end

    def update()
        @player.update(@map)
        @map.update(@player)
        update_falling_blocks()
        @enemy.update(@map)
        #p "player y: #{@player.y + Player::SIZE}"
    end

    #Calculates screen width based on map and square size.
    def calculate_screen_width()
        map_hash = @map.maps[@map.current_map] 
        map_key = map_hash.keys[0]
        map_2d_array = map_hash[map_key]
        map_array = map_2d_array[0] 
        #p "map_array: #{map_array}"
        #p "map_array length: #{map_array.length}"
        width = map_array.length * Map::SQUARE_SIZE  
        #p "width: #{width}"
        return width
    end

     #Calculates screen height based on map and square size.
    def calculate_screen_height()
        map_hash = @map.maps[@map.current_map] 
        map_key = map_hash.keys[0]
        map_2d_array = map_hash[map_key]
        #p "map_2d_array: #{map_2d_array}"
        #p "map_2d_array length: #{map_2d_array.length}"
        height = map_2d_array.length * Map::SQUARE_SIZE
        #p "height: #{height}"
        return height
    end

        #Updates all falling blocks in the current map.
    def update_falling_blocks()
        @map.blocks["falling_blocks"].each do |falling_block|
            falling_block.update(@player, @map)
        end
    end
end