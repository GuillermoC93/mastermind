class Computer
  attr_reader :code

  def initialize
    @code = [0, 0, 0, 0]
  end

  def create_code
    @code = @code.map { |n| n = rand(1..6) }
  end

  def feedback(player_guess, game_code)
    s = []
    i = 0
    while i < game_code.length
      if game_code[i] == player_guess[i]
        s << 'O'
        game_code[i] = 0
        player_guess[i] = 'X'
      end
      i += 1
    end
    i = 0
    while i < game_code.length
      s << 'X' if player_guess.include?(game_code[i])
      i += 1
    end
    s.join('')
  end

  def starter_guess
    [1, 1, 1, 1]
  end

  def comp_round_guess(comp_guess, feedback_string)
    case feedback_string.length
    when 0
      (comp_guess.to_i + 1111).to_s
    when 1
      (comp_guess.to_i + 111).to_s
    when 2
      (comp_guess.to_i + 11).to_s
    when 3
      (comp_guess.to_i + 1).to_s
    when 4
      # code a shuffle method
    end
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
    puts 'Type "1" for CODEBREAKER or "2" for CODEMAKER.'
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
    maker_starter
  end

  def start_game
    puts 'Welcome to Mastermind!'
    puts "\n"
    puts 'Would you like to be the CODEBREAKER or CODEMAKER?'
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
    game_code = code.dup
    feedback = @comp.feedback(player.guess, game_code)
    puts feedback
    @turns += 1
    feedback
  end

  def maker_starter
    puts "Turn ##{@turns}. Make a guess:"
    puts @comp.starter_guess.join('').to_s
    game_code = code.dup
    feedback = @comp.feedback(@comp.starter_guess, game_code)
    puts feedback
    @turns += 1
    feedback
  end

  
  def win?(feedback)
    feedback == 'OOOO'
  end
end
