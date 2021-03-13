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
      if player_guess.include?(game_code[i])
        s << 'X'
        player_guess[player_guess.find_index(game_code[i])] = 'X'
      end
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
      (comp_guess.join('').to_i + 1111).to_s
    when 1
      (comp_guess.join('').to_i + 111).to_s
    when 2
      (comp_guess.join('').to_i + 11).to_s
    when 3
      (comp_guess.join('').to_i + 1).to_s
    when 4
      (comp_guess.shuffle!.join('')).to_s
    end
  end

  def comp_loss
    puts "The computer couldn't guess the code!"
    puts 'You win!'
  end

  def comp_win
    puts 'The computer cracked your code!'
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

  def set_maker_code
    loop do
      maker_code = gets.chomp
      if maker_code =~ /^-?[1-6]+$/ && maker_code.length == 4
        return maker_code.split('').map(&:to_i)
      elsif maker_code.length < 4 || maker_code.length > 4
        puts 'Error! Invalid input.'
      else
        puts 'Error! Invalid input.'
      end
    end
  end
end

class Game
  attr_reader :player, :code, :player_code
  attr_accessor :next_guess

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
    puts "You chose CODEMAKER!\n\n"
    puts 'Please input a 4 digit number with each number being between 1-6'
    @player_code = player.set_maker_code
    game_code = @player_code.dup
    puts "Turn ##{@turns}. Make a guess:"
    puts @comp.starter_guess.join('').to_s
    feedback = @comp.feedback(@comp.starter_guess, game_code)
    puts feedback
    @next_guess = @comp.comp_round_guess(@comp.starter_guess, feedback)
    @turns += 1
    maker_loop
  end

  def start_game
    puts 'Welcome to Mastermind!'
    puts "\n"
    puts "Would you like to be the CODEBREAKER or CODEMAKER?\n\n"
    player.choose_path? ? code_breaker : code_maker
  end

  def max_rounds_breaker
    while @turns == 12
      if win?(breaker_round) == true
        player.win
      else
        player.loss
      end
    end
  end

  def max_rounds_maker
    while @turns == 12
      if win?(maker_round) == true
        @comp.comp_win
      else
        @comp.comp_loss
      end
    end
  end

  def breaker_loop
    game_over = false
    while game_over == false
      while @turns <= 11
        if win?(breaker_round) == true
          player.win
          break
        end
      end
      max_rounds_breaker
      game_over = true
    end
  end

  def maker_loop
    game_over = false
    while game_over == false
      while @turns <= 11
        if win?(maker_round) == true
          @comp.comp_win
          break
        end
      end
      max_rounds_maker
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

  def maker_round
    puts "Turn ##{@turns}. Make a guess:"
    puts @next_guess
    game_code = @player_code.dup
    feedback = @comp.feedback(@next_guess.split('').map(&:to_i), game_code)
    @next_guess = @comp.comp_round_guess(@next_guess.split('').map(&:to_i), feedback)
    puts feedback
    @turns += 1
    feedback
  end

  def win?(feedback)
    feedback == 'OOOO'
  end
end
