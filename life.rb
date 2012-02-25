require_relative 'grid'
require 'curses'
include Curses

begin

  x = ARGV[0] ? ARGV[0].to_i : 10
  y = ARGV[1] ? ARGV[1].to_i : 20
  init_pos = ((x * y) / 2).to_i

  Curses.init_screen
  Curses.start_color
  Curses.init_pair(COLOR_BLUE,COLOR_BLUE,COLOR_BLACK) 
  Curses.init_pair(COLOR_RED,COLOR_RED,COLOR_BLACK)

  win = Curses::Window.new x * 2, y * 2, 0, 0
  win.nodelay = true

  grid = Grid.new x, y
  (1..init_pos).each do |d|
    pos_x, pos_y = [rand(x), rand(y)]
    grid.set_cell pos_x, pos_y, true
  end

  first_pass = true

  begin
    if first_pass
      first_pass = false
    else
      grid.evolve
    end

    (0..x-1).each do |pos_x|
      (0..y-1).each do |pos_y|
        win.setpos pos_x * 2, pos_y * 2
        if grid.cell_index(pos_x, pos_y).state
          win.attron color_pair(COLOR_RED) do 
            win.addstr "X"
          end  
	else
          win.attron color_pair(COLOR_BLUE) do
	    win.addstr "O"
          end
	end
      end
    end
    win.refresh
    sleep 1
  end while (win.getch != 'q'[0])
ensure
  win.close
  Curses.close_screen
end
