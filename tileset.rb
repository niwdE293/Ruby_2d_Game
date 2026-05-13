$tileset = Tileset.new(
    'map/block_textures.png',
    tile_width: 16,
    tile_height: 16,
    padding: 0,
    spacing: 0
    )

$tileset.define_tile('grass', 0, 0)
$tileset.define_tile('ground', 1, 0)
$tileset.define_tile('sky', 0, 1)
