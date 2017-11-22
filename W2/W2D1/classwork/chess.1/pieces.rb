

class Piece
  attr_reader :type
  def initialize(position, color, type)
    @color = color
    @type = type
    @position = position
  end

  def moves
    # array of all pieces on the board
    Array.new(8) { Array.new(8) }
  end

  def valid_moves
    # return arr of valid moves for piece
  end
end

# MODULES --------------------------

module SlidingPiece
  def moves

  end

  private
  def move_dirs
  end

  def horizontal_dirs
  end

  def diagonal_dirs
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    # take Piece's move_dirs and extend to edges of board
  end
end

module SteppingPiece
end

# TYPES OF PIECES -----------------

class Bishop < Piece
  include SlidingPiece

  def initialize(position, color)
    super(position, color, type = '♗')
  end

  def move_dirs
    # diagonal_diffs = [[1,1], [-1,-1]]
  end
end

class Rook < Piece
  include SlidingPiece

  def initialize(position, color)
    super(position, color, type = "♖")
  end

  def move_dirs
    # diffs = [[0,1],[1,0],[0, -1],[-1,0]]
  end
end

class Knight < Piece
  def initialize(position, color)
    super(position, color, type = "♘")
  end
end

class Queen < Piece
  include SlidingPiece

  def initialize(position, color)
    super(position, color, type = '♕')
  end

  def move_dirs
    # diffs = [[0,1],[1,0],[0,-1],[-1,0],[1,1],[-1,-1]]
  end
end

class King < Piece
  def initialize(position, color)
    super(position, color, type = '♔')
  end
end

class Pawn < Piece
  def initialize(position, color)
    super(position, color, type = '♙')
  end
end

class NullPiece < Piece
  def initialize(position = "", color = "none", type = " ")
    super
  end
end
