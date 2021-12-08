class Code
  def initialize
    @value = ''
    @length = 4
    srand
    @length.times { @value += rand(1..4).to_s }
  end

  def assess(guess)
    GuessRating.new(@value, guess.value)
  end
end
