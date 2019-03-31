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
  update_nodes(nodes)

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

def update_nodes(nodes)
  nodes.each_with_index do |rows, row|
    rows.each_with_index do |node, col|
      if node.state == 3
        # TODO: block neighbor nodes. set state = 0 until the enemy is defeated.
      elsif node.state == 2 || node.state == 4
        # check boundaries
        top_left = nodes[row - 1][col - 1] if row - 1 >= 0 && col - 1 >= 0 && row % 2 == 0
        top_mid = nodes[row - 1][col + 0] if row - 1 >= 0
        top_right = nodes[row - 1][col + 1] if row - 1 >= 0 && col + 1 < nodes[row].size && row % 2 == 1
        mid_left = nodes[row + 0][col - 1] if col - 1 >= 0
        mid_right = nodes[row + 0][col + 1] if col + 1 < nodes[0].size
        bot_left = nodes[row + 1][col - 1] if row + 1 < nodes.size && col - 1 >= 0 && row % 2 == 0
        bot_mid = nodes[row + 1][col + 0] if row + 1 < nodes.size
        bot_right = nodes[row + 1][col + 1] if row + 1 < nodes.size && col + 1 < nodes[0].size && row % 2 == 1

        top_left.change_state if top_left && top_left.grey? # top left node for even

        top_mid.change_state if top_mid && top_mid.grey? # node above

        top_right.change_state if top_right && top_right.grey? # top right for odd

        mid_left.change_state if mid_left && mid_left.grey? # mid left

        mid_right.change_state if mid_right && mid_right.grey? # mid right

        bot_left.change_state if bot_left && bot_left.grey? # bot left for even

        bot_mid.change_state if bot_mid && bot_mid.grey? # bottom middle

        bot_right.change_state if bot_right && bot_right.grey? # botRight odd
      end
    end
  end
end

LibRay.close_window
