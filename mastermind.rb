class Mastermind
  attr_accessor :player, :computer

  def initialize
    puts "This is Mastermind.\n\nThese are the rules..."
    @player = Player.new
    @computer = Computer.new
  end

  class Player
    attr_accessor :name, :role, :code

    def initialize
      puts 'Who is playing?'
      @name = gets.chomp
      puts 'Mastermind, or Guesser? Enter "1" for Mastermind or "2" for Guesser.'
      @role = gets.chomp.to_i
      puts 'Invalid input, enter "1" for Mastermind or "2" for Guesser.' if @role < 1 || @role > 2
      @code = []
    end

    def get_input
      puts "#{name}, enter guess:"
      gets.chomp.split(' ')
    end

    def make_code
      i = 0
      while @code.length < 4
        puts "#{name}, choose one of the following colors: RED ORANGE YELLOW GREEN BLUE VIOLET"
        @code[i] = gets.chomp
        i += 1
      end
    end
  end

  class Computer
    attr_accessor :code, :init_guess

    def initialize
      @@base_colors = %w[RED ORANGE YELLOW GREEN BLUE VIOLET]
      @code = []
      i = 0
      while @code.length < 4
        @code[i] = @@base_colors.sample
        i += 1
      end
      @init_guess = []
    end

    def make_init_guess
      @init_guess = @@base_colors.sample(4)
    end
  end
end

game = Mastermind.new

role = game.player.role
computer_code = game.computer.code
black_peg = 0
white_peg = 0
incorrect_guesses = []
player_turns = 1
computer_turns = 1

if role == 1
  game.player.make_code
  puts 'Now the computer will try to guess your code...'
  player_code = game.player.code
  while computer_turns < 12
    game.computer.make_init_guess
    computer_guess = game.computer.init_guess
    puts "Code: #{player_code}"
    puts computer_guess

    computer_guess.each_with_index do |guess, ind|
      if player_code[ind] == guess
        black_peg += 1
      else
        incorrect_guesses << guess
      end
    end

    incorrect_guesses.uniq.each do |guess|
      player_code.any? do |clr|
        white_peg += 1 if clr == guess
      end
    end

    puts "Black pegs = #{black_peg}"
    puts "White pegs = #{white_peg}"

    if black_peg == 4
      p 'CPU WINS!'
      break
    end

    black_peg = 0
    white_peg = 0
    incorrect_guesses = []
    computer_turns += 1
  end

  if computer_turns >= 12
    p "The computer wasn't able to guess within 12 turns. YOU WIN! Restart the program to play again."
  end

end

if role == 2
  while player_turns < 12
    player_guess = game.player.get_input.each_with_index do |guess, ind|
      if computer_code[ind] == guess
        black_peg += 1
      else
        incorrect_guesses << guess
      end
    end

    incorrect_guesses.uniq.each do |guess|
      computer_code.any? do |clr|
        white_peg += 1 if clr == guess
      end
    end

    puts "Black pegs = #{black_peg}"
    puts "White pegs = #{white_peg}"

    if black_peg == 4
      p 'YOU WIN!'
      break
    end

    black_peg = 0
    white_peg = 0
    incorrect_guesses = []
    player_turns += 1

  end

  p "Sorry, you weren't able to guess within 12 turns. Restart the program to play again." if player_turns >= 12

end
