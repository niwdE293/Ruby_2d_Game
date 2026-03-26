class Block
  attr_accessor :x , :y, :width, :height, :color
  def initialize(x, y, width, height, color)
    @x = x
    @y = y 
    @width = width
    @height = height
    block = Rectangle.new(x: x, y: y, width: width, height: height, color: color, z: 0)
  end
end