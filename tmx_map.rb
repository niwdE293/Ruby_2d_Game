require 'tmx'

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

