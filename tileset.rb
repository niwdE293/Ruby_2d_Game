$tileset = Tileset.new(
    'map/Tileset.png',
    tile_width: 16,
    tile_height: 16,
    padding: 0,
    spacing: 0
    )

$tileset.define_tile('grass', 8, 2)
$tileset.define_tile('ground', 2, 4)
$tileset.define_tile('sky', 14, 5)
$tileset.define_tile('round_right', 12, 7)
$tileset.define_tile('round_left', 14, 7)
$tileset.define_tile('top_right', 12, 9)
$tileset.define_tile('top_left', 14, 9)
$tileset.define_tile('levitating_ground', 11, 3)
$tileset.define_tile('levitating_right', 9, 2)
$tileset.define_tile('levitating_left', 6, 2)
$tileset.define_tile('levitating_bottom', 7, 5)
$tileset.define_tile('levitating_bottom_right', 9, 5) 
$tileset.define_tile('levitating_bottom_left', 6, 5)

