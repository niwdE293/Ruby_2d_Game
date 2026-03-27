class Map
  SQUARE_SIZE = 50

  attr_accessor :blocks, :map
  def initialize()
    @blocks = []
    @map = 
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
    ]
    for y in 0..(@map.length - 1)
      array = @map[y]
      for x in 0..(array.length - 1)
        value = array[x]
        if value == 1
          @blocks << Square.new(x: x * SQUARE_SIZE, y: y * SQUARE_SIZE, size: SQUARE_SIZE, color: 'white')
        end
      end
    end
  end
end