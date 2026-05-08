require 'tmx'
require_relative 'map.tmx'

class Map
  SQUARE_SIZE = 50

  attr_accessor :blocks, :maps, :x, :y, :current_map
  def initialize()
    @blocks = {"ground" => [], "falling_blocks" => []}
    @current_map = 0
    @maps = [
    [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0], 
    [0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0], 
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
    [0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0], 
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
    [0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0], 
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
    [0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0], 
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    ],
    [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0], 
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
    [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0], 
    [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0], 
    [0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0], 
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    ]
    ]
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
    height = map.length
    for y in 0...height
      array = map[y]
      width = array.length
      for x in 0...width
        value = array[x]
        if value == 1
          @blocks["ground"] << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: 'white')
        elsif
          value == 2
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