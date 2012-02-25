require_relative 'cell'
require_relative 'grid'

describe Cell, "#livliness" do
  it "a live cell is dead if has fewer than two live neighbours" do
    cell = Cell.new true
    cell.neighbours = [Cell.new(true)]
    cell.evolve.state.should == false
  end

  it "a live cell is alive if has two live neighbours" do
    cell = Cell.new true
    cell.neighbours = [Cell.new(true), Cell.new(true)]
    cell.evolve.state.should == true
  end

  it "a live cell is alive if has three live neighbours" do
    cell = Cell.new true
    cell.neighbours = [Cell.new(true), Cell.new(true), Cell.new(true)]
    cell.evolve.state.should == true
  end  
 
  it "a live cell is dead if has more than three live neighbours" do
    cell = Cell.new true
    cell.neighbours = [Cell.new(true), Cell.new(true), Cell.new(true), Cell.new(true)]
    cell.evolve.state.should == false
  end

  it "a dead cell is alive if has exactly three alive neighbours" do
    cell = Cell.new false
    cell.neighbours = [Cell.new(true), Cell.new(true), Cell.new(true)]
    cell.evolve.state.should == true
  end 
end
 
describe Grid, "#position" do
  it "a 3x3 grid at position 0,0 has three neighbours" do
    grid = Grid.new 3, 3
    cell = grid.cell_index 0, 0
    cell.neighbours.count.should == 3
  end

  it "a 3x3 grid at position 2,2 has three neighbours" do
    grid = Grid.new 3, 3
    cell = grid.cell_index 2, 2
    cell.neighbours.count.should == 3
  end

  it "a 3x3 grid at position 1,1 has eight neighbours" do
    grid = Grid.new 3, 3
    cell = grid.cell_index 1, 1
    cell.neighbours.count.should == 8
  end
end

describe Grid, "#evolve" do
  it "a 3x3 grid at position 1,1 with three neighbours stays alive" do
    grid = Grid.new 3, 3
    grid.set_cell 1, 1, true
    grid.set_cell 0, 0, true
    grid.set_cell 2, 2, true
    grid.set_cell 1, 2, true

    grid.evolve 
    cell = grid.cell_index 1, 1
    cell.state.should == true
  end

  it "a 3x3 grid at position 1,1 with three one neighbour dies" do
    grid = Grid.new 3, 3
    grid.set_cell 1, 1, true
    grid.set_cell 0, 0, false

    grid.evolve
    cell = grid.cell_index 1, 1
    cell.state.should == false
  end

  it "a 3x3 grid at position 0,0 with exactly three neighbours lives" do
    grid = Grid.new 3, 3
    grid.set_cell 0, 0, false
    grid.set_cell 1, 0, true
    grid.set_cell 1, 1, true
    grid.set_cell 0, 1, true

    grid.evolve
    cell = grid.cell_index 0, 0
    cell.state.should == true
  end
end
