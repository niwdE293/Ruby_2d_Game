require 'tmx'


#class Tmx_map

    # def initialize()
    #     @tileset = Tileset.new(
    #     'map/Tileset.png',
    #     tile_width: 16,
    #     tile_height: 16,
    #     padding: 0,
    #     spacing: 0
    #     )

    # end


    #loads a Tmx file and converts it into a 2d array.
    def get_map(dir)
        map = Tmx.load(dir) 
        layer = map.layers[0]
        map_arr = []

        row = []
        p layer
        p layer.data.length
        count = 0
        while layer.data[0] != nil
            if count == layer.width
                count = 0
                map_arr << row
                row = []
            else
                row << layer.data[0]
                layer.data.delete_at(0)
                count += 1
            end
        end
        map_arr << row
        return map_arr
    end 

    def set_tiles()
        tile_ids = get_tile_ids()
        tile_positions = get_tile_positions()
        while i < tile_ids.length
            tile_id = tile_ids[i]
            tile_pos = tile_positions[i]
            i += 1
        end
    end

    def get_tile_info()
        tile_info = {}
        tile_ids = get_tile_ids()
        tile_positions = get_tile_positions()
        while i < tile_ids.length
            tile_id = tile_ids[i]
            tile_pos = tile_positions[i]
            x = tile_pos[0]
            y = tile_pos[1]
            tile
            i += 1
        end
        return tile_info
    end

    def get_tile_positions()
        box_size = 16
        positions = []
        width = 256
        height = 192
        y = 0
        while y < height / box_size
            x = 0
            while x < width / box_size
                positions << [x, y]
                x += 1
            end
            y += 1
        end
        return positions
    end

    def get_tile_ids()
        values = []
        value = 0
        width = 256
        height = 192
        y = 0
        while y < height
            x = 0
            while x < width
                values << value
                value += 1
                x += 16
            end
            y += 16
        end
        return values
    end

#p get_tile_values()
p get_tile_pos()



# elsif value == 23 
#     @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
#     $tileset.set_tile('grass_bottom_wall', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])

