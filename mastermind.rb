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

    def guess_checker
      []
    end

    def clue_generator; end
  end

  p player.name
end
