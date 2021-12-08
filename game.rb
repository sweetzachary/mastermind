require './code'
require './guess_rating'
require './guess'

class Game
  def initialize
    @code = Code.new
    @turns = 12
  end

  def run
    until finished?
      read
      assess
      display
    end
  end

  private

  def read
    puts 'Enter a guess consisting of 4 numbers from 1 to 6 each.'
    @guess = Guess.new(gets(4))
  end

  def assess
    @guess_rating = @code.assess(@guess)
  end

  def display
    puts "Your guess rating #{@guess_rating.value}"
    puts "#{@turns} turns remaining."
  end

  def finished?
    @guess_rating and
      if @guess_rating.correct?
        puts 'YOU WON!'
      elsif @turns <= 0
        puts 'YOU LOST'
      else
        @turns -= 1
      end
  end
end

game = Game.new
game.run
