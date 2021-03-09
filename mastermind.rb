class Computer
  attr_reader :code

  def initialize
    @code = [0, 0, 0, 0]
  end

  def create_code
    @code = @code.map { |n| n = rand(1..6) }
  end

  def feedback(player_guess)
    i = 0
    s = []
    while i <= player_guess.length - 1
      if code[i] == player_guess[i]
        s << 'X'
      elsif code.include?(player_guess[i])
        s << 'O'
      end
      i += 1
    end
    s.join('')
  end
end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess
    gets.chomp.split('').map { |n| n.to_i }
  end
end

class Game
  def initialize
    @player = Player.new
  end
end