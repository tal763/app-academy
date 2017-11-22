require_relative "board.rb"

class Game
  def initialize
    @board = Board.new
  end

  def run
    play_game while !game_over

  end

  def play_game
    system('clear')
    @board.render
    puts " enter a move (f 0,1) || (r 0,1) "
    input = parse_input(gets.chomp)
    if input[0] == "r"
      @board.reveal(input[1])
    else
      @board.flag(input[1])
    end
  end

  def parse_input(string)
    input = string.split(" ")
    pos = input[1].split(",").map { |char| Integer(char) }
    [input[0], pos]
  end

  def game_over
    return false
  end


end
