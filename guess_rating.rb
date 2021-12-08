class GuessRating
  def initialize(code, guess)
    tmp = code.clone
    @value = guess.split('').zip(tmp.split('')).map do |guess, code|
      if guess == code
        tmp.sub!(guess, '')
        'C'
      end
    end
    @value = guess.split('').zip(@value).map do |guess, val|
      val or
        if tmp.include?(guess)
          tmp.sub!(guess, '')
          'G'
        end
    end
    @value.map! { |v| v || '-' }
    @value = value.join('')
  end

  attr_reader :value
end
