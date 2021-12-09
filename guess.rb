class Guess
  def initialize(str)
    @value = str
    @possibilities = [*'1'..'6']
  end

  def improve(guess_rating)
    @val = @value.split('')
    @rating = guess_rating.value.split('')
    change_probabilities
    update
    p @val
    @value = @val.join('')
  end

  attr_reader :value

  private

  def change_probabilities
    @val.zip(@rating).each do |v, r|
      case r
      when 'C'
        @possibilities.delete_at(@possibilities.index(v) || @possibilities.length)
      when 'G'
        @possibilities.push(v)
      else
        @possibilities.delete_at(@possibilities.index(v) || @possibilities.length)
      end
    end
  end

  def update
    @val = @val.zip(@rating).map do |v, r|
      if r != 'C'
        @possibilities[rand(@possibilities.length)]
      else
        v
      end
    end
  end
end
