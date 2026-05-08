require 'tmx'
require 'ruby2d' 

def get_data()
    Tmx.load('map.tmx', options = {})
end

p get_data()