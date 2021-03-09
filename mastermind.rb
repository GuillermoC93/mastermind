class Computer
  attr_reader :code

  def initialize
    @code = [0, 0, 0, 0]
  end

  def create_code
    @code = @code.map { |n| n = rand(1..6) }
  end

  def feedback(user_guess)
    i = 0
    s = []
    while i <= user_guess.length - 1
      if self.code[i] == user_guess[i]
        s << 'X'
      elsif self.code.include?(user_guess[i])
        s << 'O'
      end
      i += 1
    end
    s.join('')
  end
end

comp = Computer.new
comp.create_code
p comp.code
p comp.feedback([1, 2, 3, 4])