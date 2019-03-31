class Node
  property color : LibRay::Color
  property state : Int32
  property position_x
  property position_y

  def initialize(@position_x : Int32, @position_y : Int32)
    @color = LibRay::GRAY
    @state = 0
  end

  def change_state
    @state += 1
    set_color(@state)
  end

  def grey?
    state == 0
  end

  def change_state(value : Int32)
    @state = value
    set_color(@state)
  end

  def set_color(state)
    case state
    when 0
      @color = LibRay::GRAY # not reached
    when 1
      @color = LibRay::ORANGE # reachable
    when 2
      @color = LibRay::GREEN # hidden. may carry item or enemy
    when 3
      @color = LibRay::RED # enemy
    when 4
      @color = LibRay::BLUE # cleared
    end
  end

  def draw
    LibRay.draw_circle(position_x, position_y, 10, color)
  end
end
