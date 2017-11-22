class Tile
  attr_accessor :num_neighbor_mines, :is_flipped, :is_mine
  attr_reader :is_revealed
  
  def initialize
    @is_mine = false
    @is_revealed = false
    @num_neighbor_mines = 0
    @is_flagged = false
  end

  def to_s
    return "X" if is_mine
    return num_neighbor_mines.to_s
  end

  def flag
    @is_flagged = !@is_flagged
  end

  def reveal
    @is_revealed = true
  end
end
