class Mastermind
  attr_accessor :player, :computer

  def initialize
    puts "This is Mastermind.\n\nThese are the rules..."
    @player = Player.new
    @computer = Computer.new
  end

  class Player
    def initialize
      puts 'Who is playing?'
      @name = gets.chomp
    end

    def play_round
      puts 'Player, enter guess:'
      gets.chomp.split(' ')
    end
  end

  class Computer
    attr_accessor :code

    def initialize
      @@base_colors = %w[RED ORANGE YELLOW GREEN BLUE VIOLET]
      @code = []
      i = 0
      while @code.length < 4
        @code[i] = @@base_colors.sample
        i += 1
      end
    end
  end
end

game = Mastermind.new

player_guess = game.player.play_round
computer_code = game.computer.code
compare_clr_and_pos = []
compare_clr_only = 0

player_guess.each_with_index do |obj, ind|
  compare_clr_and_pos[ind] = computer_code[ind] == obj
  computer_code.any? do |clr|
    compare_clr_only += 1 if clr == obj
  end
end

p player_guess
p computer_code
p compare_clr_and_pos
p compare_clr_only
