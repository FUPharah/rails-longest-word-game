require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { [*'a'..'z'].sample }.join
  end

  def score
    @attempt = params[:new]
    @grid = params[:grid]
    #@grid.scan(/\w+/)
    if english_word? && valid_word?(@grid, @attempt)  == true
      @won = "winner!"
    else
      @won = "Loser!"
    end
  end

  # def in_the_grid? ( )

  # end

  def valid_word?(letters, word)
    letters = letters.chars
    word.downcase.chars.each do |letter|
      return false unless letters.include?(letter)

      letters.delete_at(letters.index(letter))
    end
    true
  end

  def english_word?
    dictionary = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    serialized_json = URI.open(dictionary).read
    json = JSON.parse(serialized_json)
    json['found']
  end
end
