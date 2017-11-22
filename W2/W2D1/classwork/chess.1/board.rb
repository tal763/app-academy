#  Your Board class should hold a 2-dimensional array (an array of arrays). Each position in the board either holds a moving Piece or a NullPiece (NullPiece will inherit from Piece).
#
# You'll want to create an empty Piece class as a placeholder for now. Write code for #initialize so we can setup the board with instances of Piece in locations where a Queen/Rook/Knight/ etc. will start and nil where the NullPiece will start.
#
# The Board class should have a #move_piece(start_pos, end_pos) method. This should update the 2D grid and also the moved piece's position. You'll want to raise an exception if:
#
# there is no piece at start_pos or
# the piece cannot move to end_pos.
require 'byebug'
require_relative 'pieces.rb'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    set_board
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def royalty(grid_row, color)
    [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook].each_with_index do |piece, idx|
      self[[grid_row, idx]] = piece.new([grid_row, idx], color)
    end
  end

  def pawns(grid_row, color)
    8.times do |idx|
      self[[grid_row, idx]] = Pawn.new([grid_row, idx], color)
    end
  end

  def nulls(grid_row)
    8.times do |idx|
      self[[grid_row, idx]] = NullPiece.new
    end
  end

  def set_board
    royalty(0, "white")
    royalty(7, "black")
    pawns(1, "white")
    pawns(6, "black")
    nulls(2)
    nulls(3)
    nulls(4)
    nulls(5)

  end

  def move_piece(start_pos, end_pos)
    # called by game.turn
    # if move in_bounds?
    if self[start_pos].type == " "
      raise ArgumentError.new("There's no piece in that position")
    end

    moving_piece = self[start_pos]

    if in_bounds?(end_pos)

    else

    self[end_pos] = moving_piece
    self[start_pos] = nil
    p self


    # You'll want to raise an exception if:

   # there is no piece at start_pos or
   # the piece cannot move to end_pos.
  end
end

  def in_bounds?
    # if a piece tries to move off the board, raise error
  end

end
