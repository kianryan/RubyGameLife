require_relative 'grid'
require 'curses'

begin
  Curses.init_screen
  win = Curses::Window.new 20, 40, 0, 0
  win.nodelay = true

  x, y = [10, 20]

  grid = Grid.new x, y
  (1..50).each do |d|
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


    (0..x-1).each do |x|
      (0..y-1).each do |y|
        win.setpos(x * 2, y * 2)
        if grid.cell_index(x, y).state
        	win.addstr "X"
	else
		win.addstr "O"
	end
      end
    end
    win.refresh
    sleep 1
  end while (win.getch != 'q'[0])
ensure
  win.close
end
