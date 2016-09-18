require_relative "board.rb"
require_relative "card.rb"
require "byebug"
class Game
  def initialize()
    @board = Board.new(4)
    @previous_pos = nil
    @board.populate
  end

  def play
    until @board.won?
      puts "##"
      @board.render
      prompt
      guess_pos = gets.chomp.to_i
      setup(guess_pos)
    end
  end

  def prompt
    puts "Where do you want to check?"
  end

  def setup(guess_pos)
    if @previous_pos.nil?
      first_guess(guess_pos)
    else
      second_guess(guess_pos)
      @previous_pos = nil
    end

  end

  def first_guess(guess_pos)
    @board.reveal(guess_pos)
    @previous_pos = guess_pos
  end

  def second_guess(guess_pos)
    if match?(guess_pos)
      @board.reveal(guess_pos)
      @board.reveal(@previous_pos)
      @board.render
    else
      handle_mismatch(guess_pos)
    end
  end

  def match?(guess_pos)
    @board.return_card(guess_pos).number == @board.return_card(@previous_pos).number
  end

  def handle_mismatch(guess_pos)
    @board.reveal(guess_pos)
    @board.render
    @board.return_card(guess_pos).hide
    @board.return_card(@previous_pos).hide
    sleep(3)
    system("clear")
  end
end

game = Game.new
game.play
