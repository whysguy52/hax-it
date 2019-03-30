class Node
  property color

  def initialize
    @color = LibRay::WHITE
  end

  def draw
    LibRay.draw_circle(20, 20, 5, color)
  end
end
