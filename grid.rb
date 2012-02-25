require_relative 'cell'

class Grid

  attr_accessor :cells

  def initialize x, y
    @x = x
    @y = y
    @cells = new_grid 
    set_neighbours
  end

  def new_grid
    Array.new(@x) {Array.new(@y) { Cell.new false } }
  end

  def set_neighbours 
    (0..@x-1).each do |i|
      (0..@y-1).each do |j|
        cell = @cells[i][j]
        (i-1..i+1).reject { |k| k < 0 or k == @x }.each do |row_i| 
          (j-1..j+1).reject { |k| k < 0 or k == @y }.each do |row_j|
            neighbour = @cells[row_i][row_j]
            cell.neighbours << neighbour unless neighbour == nil or neighbour == cell
          end
        end        
      end
    end
  end

  def cell_index x, y
    @cells[x][y]
  end

  def evolve
    new_cells = new_grid
    (0..@x-1).each do |i|
      (0..@y-1).each do |j|
        new_cells[i][j] = @cells[i][j].evolve
      end
    end
    @cells = new_cells
    set_neighbours
    @cells
  end

  def set_cell x, y, state
    @cells[x][y].state = state
  end
end
