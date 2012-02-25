class Cell

  attr_accessor :neighbours
  attr_accessor :state

  def initialize state
    @state = state
    @neighbours = Array.new
  end

  def evolve
    live_count = @neighbours.count do |x| x.state end
    
    new_state = false if @state and live_count < 2
    new_state = true if @state and (live_count == 2 or live_count == 3)
    new_state = false if @state and live_count > 3 
    new_state = true if ! @state and live_count == 3 

    Cell.new new_state
  end

  def to_s
    @state.to_s + " n=" + neighbours.count.to_s
  end

  def to_str
    to_s  
  end

end
