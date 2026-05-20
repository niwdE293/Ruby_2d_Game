class Game 
    attr_accessor :player, :map
    def initialize()
        @player = Player.new()
        @map = Map.new()
    end

    def update()
        @player.update(@map)
        @map.update(@player)
    end

    def calculate_screen_width()
        width = @map.maps[@map.current_map][0].length * Map::SQUARE_SIZE  
        return width
    end

    def calculate_screen_height()
        height = @map.maps[@map.current_map].length * Map::SQUARE_SIZE
        return height
    end
end