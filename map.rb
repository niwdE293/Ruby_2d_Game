class Map
  SQUARE_SIZE = 50

  attr_accessor :blocks, :maps, :x, :y, :current_map
  def initialize()
    @blocks = []
    @current_map = 0
    @maps = [
    [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
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
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
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
  end
  
  def check_map_swap(player)
    if player.outside_screen_position == "right"
      if @current_map < @maps.length - 1
        load_next_map()
        #player.x = - (Player::SIZE / 2)  # 0
      #else 
        #player.x = $screen_width - Player::SIZE
      end

    elsif player.outside_screen_position == "left"
      if @current_map > 0 
        load_previous_map()
        #player.x = $screen_width - (Player::SIZE / 2)  # $screen_width - Player::SIZE
      #else
        #player.x = 0
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
          @blocks << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: 'white')
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
    @blocks.each do |block|
      block.remove
    @blocks = []
    end
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
end
      
