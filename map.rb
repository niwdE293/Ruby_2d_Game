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
        if value == 40
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('grass', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 67
          $tileset.set_tile('ground', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 95 
          $tileset.set_tile('sky', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 125 
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('round_right', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 127
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('round_left', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 157 
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('top_right', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 159 
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('top_left', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 42 
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('levitating_right', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 39  
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('levitating_left', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 89  
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('levitating_bottom', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 90
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('levitating_bottom_right', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 87
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          $tileset.set_tile('levitating_bottom_left', [{x: x * SQUARE_SIZE, y: y * SQUARE_SIZE}])
        elsif value == 0
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: [0, 0, 0, 0])
          @blocks["falling_blocks"] << Falling_block.new(x * SQUARE_SIZE, y * SQUARE_SIZE, self)
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