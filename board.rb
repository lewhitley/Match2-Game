require_relative "card.rb"
require "byebug"

class Board
  def initialize(size = 4)
    @grid = Array.new(size)
  end

  attr_reader :grid

  def populate
    num_card = @grid.flatten.length/2
    all_card = []
    (1..num_card).each do |card|
      all_card.push(Card.new(card))
      all_card.push(Card.new(card))
    end
    @grid = all_card.shuffle
  end

  def render
    render_arr = @grid.map do |card|
      # debugger
      if card.face_up
        card.number
      else
        "x"
      end
    end
    p render_arr
  end

  def won?
    @grid.all? { |card| card.face_up }
  end

  def reveal(guess_pos)
    card = @grid[guess_pos]
    unless card.face_up
      card.reveal
      card.number
    end
  end

  def return_card(pos)
    @grid[pos]
  end

end
