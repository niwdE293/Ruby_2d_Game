require 'tmx'
require_relative 'tmx_map.rb'
require_relative 'tileset.rb'


class Map
  SQUARE_SIZE = 16

  attr_accessor :blocks, :maps, :x, :y, :current_map
  def initialize()
    @blocks = {"ground" => [], "falling_blocks" => []}
    @current_map = 0
    @maps = [get_map('map/map.tmx'), get_map('map/map2.tmx')]
    first_map = @maps[@current_map]
    draw_map(first_map)
  end

  def update(player)
    check_map_swap(player)
    update_falling_blocks(player)
  end
  
  def update_falling_blocks(player)
    @blocks["falling_blocks"].each do |falling_block|
      falling_block.update(player)
    end
  end
    

  def check_map_swap(player)
    first_map = 0
    last_map = maps.length - 1
    player_center = Player::SIZE / 2

    if current_map == first_map
      if player.outside_screen_position() == "left"
        player.x = 0
      else
        if player.center_outside_screen_position() == "right"
          load_next_map()
          player.x = - player_center
        end
      end
    elsif current_map == last_map
      if player.outside_screen_position() == "right"
        player.x = $screen_width - Player::SIZE
      else
        if player.center_outside_screen_position() == "left"
          load_previous_map()
          player.x = $screen_width - player_center
        end
      end

    else
      if outside_screen_position() == "right"
        load_next_map()
        player.x = - player_center
      elsif outside_screen_position() == "left"
        load_previous_map()
        player.x = $screen_width - player_center
      end
    end
  end
  

  def draw_map(map)
    p map 
    height = map.length
    for y in 0...height
      array = map[y]
      width = array.length
      for x in 0...width
        value = array[x]
        if value == 19
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('grass', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 20
          $tileset.set_tile('grass_right_wall', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 18 
          $tileset.set_tile('grass_left_wall', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 23 
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('grass_bottom_wall', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 24
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('grass_bottom_right_wall', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 22 
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('grass_bottom_left_wall', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 26
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('grass_sides_wall', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 54 
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('grass_around_wall', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 28  
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('grass_top_right', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 30  
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('grass_top_left', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 44
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('grass_right', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 46
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('grass_left', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 60
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('grass_top_corner_right', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 62
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('grass_top_corner_left', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])

        elsif value == 35
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('ground', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 36
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('ground_right', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 34
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('ground_left', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 51
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('ground_bottom', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 52
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('ground_bottom_right', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 50
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('ground_bottom_left', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 42
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('ground_sides', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 58
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('ground_sides_bottom', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])

        elsif value == 84
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('big_icicle_1', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 85
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('big_icicle_2', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 100
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('big_icicle_3', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 101
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('big_icicle_4', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 116
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('icicles_1', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 117
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('icicles_2', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])

        elsif value == 82
          $tileset.set_tile('sky', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        #elsif value == 0
          #@blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          #@blocks["falling_blocks"] << Falling_block.new(x * SQUARE_SIZE, y * SQUARE_SIZE, self)
        end
      end
    end
  end

  def load_next_map()
    delete_current_map()
    @current_map += 1
    map = @maps[current_map]
    draw_map(map)
  end

  def load_previous_map()
    delete_current_map
    @current_map -= 1
    map = @maps[current_map]
    draw_map(map)
  end

  def delete_current_map()
    @blocks.each_value do |blocks|
      blocks.each do |block|
        block.remove
      end
    end
    @blocks = {"ground" => [], "falling_blocks" => []}
  end

  def next_map_exists?()
    if @maps[@current_map + 1]  != nil
      return true
    else 
      return false
    end
  end

  def previous_map_exists?()
    if @current_map < 1
      return false
    else 
      return true
    end
  end

  def remove_falling_block(block)
    for i in 0..@blocks["falling_blocks"].length 
      comparison_block = @blocks["falling_blocks"][i] 
      p comparison_block
      if block == comparison_block
        @blocks["falling_blocks"].delete_at(i)
      end
    end
  end
end