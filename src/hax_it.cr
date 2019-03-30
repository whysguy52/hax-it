require "cray"
require "./objects/*"
# This example will automatically scale with the window.

LibRay.set_config_flags LibRay::FLAG_WINDOW_RESIZABLE
LibRay.init_window 640, 480, "Hax It"
node = Node.new

while !LibRay.window_should_close?
  # movement
  delta_t = LibRay.get_frame_time

  # draw
  LibRay.begin_drawing
  LibRay.clear_background LibRay::BLACK
  LibRay.draw_fps(0, 0)
  node.draw

  LibRay.end_drawing
end

LibRay.close_window
