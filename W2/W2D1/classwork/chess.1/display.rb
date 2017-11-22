require_relative "board.rb"
require_relative "cursor.rb"
require "colorize"
require 'byebug'

class Display

  def initialize
    @board = Board.new
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    @board.grid.each_with_index do |row, idx|
      row.each_with_index do |col, idx2|
        if [idx, idx2] == @cursor.cursor_pos
          print "#{col.type} ".colorize(:blue).colorize(:background => :red)
        else
          print "#{col.type} ".colorize(:blue)
        end
      end
      puts "\n"
    end
    nil
  end

  # Move this logic to Game class:
  # until game_over? // player switch?
  # Moves off the board?
  def move_cursor
      @cursor.get_input
      render
      @cursor.get_input
      render
  end

end
