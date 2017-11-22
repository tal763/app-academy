require_relative "tile"
require "byebug"

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(9) { Array.new(9) {Tile.new}}
    10.times do
      pos = [rand(0..8), rand(0..8)]
      while(self[pos].is_mine)
        pos = [rand(0..8), rand(0..8)]
      end
      self[pos].is_mine = true
    end
    init_mine_neighbors
  end

  def [](pos)
    x , y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def render
    @grid.each_with_index do |tiles, row|
      tiles.each_index do |col|
        tile = self[[col,row]]
        if !tile.is_revealed
          print " * "
        elsif tile.is_mine
          print " X "
        elsif tile.num_neighbor_mines != 0
          print tile.num_neighbor_mines
        elsif tile.is_flagged
          print " F "
        else
          print "   "
        end
      end
      puts
    end
  end

  def init_mine_neighbors
    @grid.each_with_index do |tiles, row|
      tiles.each_index do |col|
        tile = self[[col, row]]
        next if tile.is_mine
        num = 0
        neighbors = neighbors([col, row])
        neighbors.each do |neighbor|
          num += 1 if self[neighbor].is_mine
        end
        tile.num_neighbor_mines = num
      end
    end
  end

  def neighbors(pos)
    neighbors = []
    deltas = [[-1,0], [1,0], [0,1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]
    deltas.each do |delta|
      new_pos = [pos[0] + delta[0], pos[1] + delta[1]]
      neighbors << new_pos if new_pos.all? { |el| el.between?(0, @grid.length-1) }
    end
    neighbors
  end

  def flag(pos)
    self[pos].flag
  end

  def reveal(pos)
    return if self[pos].is_flagged
    seen_neighbors = []
    self[pos].reveal
    return false if self[pos].is_mine
    return true if self[pos].num_neighbor_mines != 0
    neighbors = neighbors(pos)
    seen_neighbors << pos
    while(neighbors.length > 0)
      neighbors.each do |neighbor|
        seen_neighbors << neighbor
        self[neighbor].reveal
        possible_neighbors = neighbors(neighbor)
        neighbors.delete(neighbor)
        next if self[neighbor].is_mine || self[neighbor].num_neighbor_mines != 0
        possible_neighbors.each do |possible_neighbor|
          if !seen_neighbors.include?(possible_neighbor)
            neighbors << possible_neighbor
          end
        end
      end
    end
  end

end
