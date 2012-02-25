require 'curses'
include Curses

Curses.noecho  #do not show typed keys
Curses.init_screen
Curses.stdscr.keypad(true) 
Curses.start_color
Curses.init_pair(COLOR_BLUE,COLOR_BLUE,COLOR_BLACK) 
Curses.init_pair(COLOR_RED,COLOR_RED,COLOR_BLACK)

 loop do

   case Curses.getch

     when 'q'
         Curses.clear
         Curses.setpos(0,0)
         Curses.attron(color_pair(COLOR_RED)|A_NORMAL){
            Curses.addstr("Page Up")
         }
     when 'a'
          Curses.clear
          Curses.setpos(0,0)
          Curses.attron(color_pair(COLOR_BLUE)|A_NORMAL){
            Curses.addstr("Page Down")
          }
          Curses.addstr("Bob")
   end
end
