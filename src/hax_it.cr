require "cray"
require "./objects/*"
# This example will automatically scale with the window.

LibRay.set_config_flags LibRay::FLAG_WINDOW_RESIZABLE
LibRay.init_window 640, 480, "Hax It"
nodes = [] of Node
node_position_x = 0
node_position_y = 0
section_size = LibRay.get_screen_width / 8
center_offset = section_size / 2

nodes = Array.new(6) do |i|
  node_position_y = i * section_size + center_offset
  Array.new(7) do |j|
    node_position_x = j * section_size + center_offset
    if i % 2 == 1
      node_position_x += center_offset
    end
    Node.new(node_position_x, node_position_y)
  end
end

nodes[0][0].change_state(4)

while !LibRay.window_should_close?
  # movement
  delta_t = LibRay.get_frame_time
  did_click?(nodes)

  # draw
  LibRay.begin_drawing
  LibRay.clear_background LibRay::BLACK
  LibRay.draw_fps(0, 0)
  nodes.each do |rows|
    rows.each do |node|
      node.draw
    end
  end
  # node.draw

  LibRay.end_drawing
end

def did_click?(nodes)
  mouse_x = LibRay.get_mouse_x
  mouse_y = LibRay.get_mouse_y
  nodes.each do |rows|
    rows.each do |node|
      if mouse_x > node.position_x - 10 && mouse_x < node.position_x + 10
        if mouse_y > node.position_y - 10 && mouse_y < node.position_y + 10
          if LibRay.mouse_button_pressed?(LibRay::MOUSE_LEFT_BUTTON)
            node.change_state
          end
        end
      end
    end
  end
end

LibRay.close_window
