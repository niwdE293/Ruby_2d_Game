$tileset = Tileset.new(
    'map/Tileset.png',
    tile_width: 16,
    tile_height: 16,
    padding: 0,
    spacing: 0
    )

$tileset.define_tile('grass', 2, 1) #19
$tileset.define_tile('grass_right_wall', 3, 1) #20
$tileset.define_tile('grass_left_wall', 1, 1) #18
$tileset.define_tile('grass_bottom_wall', 6, 1) #23
$tileset.define_tile('grass_bottom_right_wall', 7, 1) #24
$tileset.define_tile('grass_bottom_left_wall', 5, 1) #22
$tileset.define_tile('grass_sides_wall', 9, 1) #26
$tileset.define_tile('grass_around_wall', 5, 3) #54
$tileset.define_tile('grass_top_right', 11, 1) #28
$tileset.define_tile('grass_top_left', 13, 1) #30
$tileset.define_tile('grass_right', 11, 2) #44
$tileset.define_tile('grass_left', 13, 2) #46
$tileset.define_tile('grass_top_corner_right', 11, 3) #60
$tileset.define_tile('grass_top_corner_left', 13, 3) #62

$tileset.define_tile('ground', 2, 2) #35
$tileset.define_tile('ground_right', 3, 2) #36
$tileset.define_tile('ground_left', 1, 2) #34
$tileset.define_tile('ground_bottom', 2, 3) #51
$tileset.define_tile('ground_bottom_right', 3, 3) #52
$tileset.define_tile('ground_bottom_left', 1, 3) #50
$tileset.define_tile('ground_sides', 9, 2) #42
$tileset.define_tile('ground_sides_bottom', 9, 3) #58

$tileset.define_tile('big_icicle_1', 3, 5) #84
$tileset.define_tile('big_icicle_2', 4, 5) #85
$tileset.define_tile('big_icicle_3', 3, 6) #100
$tileset.define_tile('big_icicle_4', 4, 6) #101
$tileset.define_tile('icicles_1', 3, 7) #116
$tileset.define_tile('icicles_2', 4, 7) #117

$tileset.define_tile('sky', 1, 5) #82

