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
    while i <= code.length - 1
      if code[i] == player_guess[i]
        s << 'O'
      elsif code.include?(player_guess[i])
        s << 'X'
      end
      i += 1
    end
    s.join('')
  end
end

class Player
  def guess
    loop do
      guess = gets.chomp
      if guess =~ /^-?[1-6]+$/ && guess.length == 4
        return guess.split('').map(&:to_i)
      elsif guess.length < 4 || guess.length > 4
        puts 'Error! Invalid input.'
      else
        puts 'Error! Invalid input.'
      end
    end
  end
end

class Game
  attr_reader :player, :code

  def initialize
    @player = Player.new
    @code = Computer.new.create_code
  end

  def game_loop
    
  end
end
