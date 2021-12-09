require './code'
require './guess_rating'
require './guess'

class Game
  def initialize
    @code = Code.new
    @turns = 12
  end

  def run
    welcome
    choose_mode
    until finished?
      case @game_mode
      when :codebreaker
        play_codebreaker_turn
      when :codemaker
        play_codemaker_turn
      end
    end
  end

  private

  def play_codebreaker_turn
    read
    assess
    display
  end

  def play_codemaker_turn
    make_guess
    get_rating
    display_turns
  end

  def make_guess
    @guess ||= Guess.new('1122')
    @guess.improve(@guess_rating) if @guess_rating
    puts "My guess is #{@guess.value}"
  end

  def display_turns
    puts "#{@turns} turns remaining."
  end

  def get_rating
    puts 'Rate my guess:'
    @guess_rating = GuessRating.new(nil, nil, str: gets.chomp)
  end

  def welcome
    puts 'Welcome to the game of Mastermind! Refer to README.md for information.'
  end

  def choose_mode
    codebreaker_names = { 1 => 'You', 2 => 'Computer' }
    choice = 0
    until choice.between?(1, 2)
      puts 'Choose game mode:'
      puts '1) Codebreaker'
      puts '2) Codemaker'
      choice = gets.to_i
    end
    @codebreaker = codebreaker_names[choice]
    @game_mode = %i[codebreaker codemaker][choice - 1]
  end

  def read
    puts 'Enter a guess consisting of 4 numbers from 1 to 6 each.'
    @guess = Guess.new(gets.chomp)
  end

  def assess
    @guess_rating = @code.assess(@guess)
  end

  def display
    puts "Your guess rating #{@guess_rating.value}"
    display_turns
  end

  def finished?
    @guess_rating and
      if @guess_rating.correct?
        puts "#{@codebreaker} WON!"
        true
      elsif @turns <= 0
        puts "#{@codebreaker} LOST."
        true
      else
        @turns -= 1
        false
      end
  end
end

game = Game.new
game.run
