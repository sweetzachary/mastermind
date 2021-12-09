class GuessRating
  def initialize(code, guess, str: nil)
    if str
      @value = str
      @value.upcase!
      return
    end
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

  def correct?
    @value.each_char.all? 'C'
  end

  attr_reader :value
end
