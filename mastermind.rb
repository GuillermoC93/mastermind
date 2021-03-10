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
    s.shuffle.join('')
  end

  def starter_guess
    '1111'
  end

  def comp_breaker
    
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

  def choose_path?
    puts 'Would you like to be the CODEBREAKER or CODEMAKER?'
    path = gets.chomp
    until path == '1' || path == '2'
      puts "Please input '1' or '2'"
      path = gets.chomp
    end
    case path
    when '1' then true
    when '2' then false
    end
  end

  def loss
    puts 'You lose :('
  end

  def win
    puts 'You cracked the code!'
  end
end

class Game
  attr_reader :player, :code

  def initialize
    @player = Player.new
    @comp = Computer.new
    @code = @comp.create_code
    @turns = 1
  end

  def code_breaker
    puts 'An "O" means right number, right position!'
    puts 'An "X" means right number, wrong position!'
    puts "\n"
    breaker_loop
    puts 'Thanks for playing!'
  end

  def code_maker
    puts 'You chose CODEMAKER!'
  end

  def start_game
    puts 'Welcome to Mastermind!'
    puts "\n"
    player.choose_path? ? code_breaker : code_maker
  end

  def breaker_loop
    game_over = false
    while game_over == false
      while @turns <= 12
        if win?(breaker_round) == true
          player.win
          break
        end
      end
      if @turns > 12
        player.loss
        break
      end
      game_over = true
    end
  end

  def breaker_round
    puts "Turn ##{@turns}. Make a guess:"
    feedback = @comp.feedback(player.guess)
    puts feedback
    @turns += 1
    feedback
  end

  def win?(feedback)
    feedback == 'OOOO'
  end
end
