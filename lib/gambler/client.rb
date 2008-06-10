module Gambler

  # A simple Client which allows you to play around with Gambler.
  # Most of this class can be ignored, as it just sets up the gaming
  # environment.  The method to pay attention to is +play_blackjack+.
  # This is the method that actually creates and deals a Blackjack game.
  class Client
    WIDTH = 50

    $player_quits = false

    attr_accessor :bots
    attr_accessor :player

    def initialize
      @player = setup_player
      @bots = Array.new
    end

    # This is the main client menu.
    def menu
      display_header
      until $player_quits do
        display_player_stats
        display_game_menu
        choice = STDIN.gets.chomp

        case choice
        when '1':
          play_blackjack
        when '2':
          puts 'This game is not implemented yet.'
        when '3':
          puts 'This game is not implemented yet.'
        when /a/i:
          add_ai_player
        when /p/i:
          setup_player
        when /d/i:
          debug_console
        when /q/i:
          $player_quits = true
          exit
        else
          puts 'Invalid choice, dumbass.'
        end
      end
    end # of menu

    private

    # Add an AI Player as an opponent.
    def add_ai_player
      @bots << setup_player(:bot => true)
    end

    # Simple debugging console.
    def debug_console
      stop_debug = false
      code = Array.new

      puts # spacer
      puts '== DEBUG CONSOLE =='
      puts 'Commands:'
      puts '  /run  - Quit debugger and run the code.'
      puts '  /show - Show the code currently in the buffer.'
      puts '  /quit - Quit debugger without running the code.'

      until stop_debug do
        print "eval:#{code.size + 1}> "
        line = STDIN.gets.chomp

        case line
        when '/run':
          run_code(code)
          stop_debug = true
        when '/show':
          show_code_buffer(code)
        when '/quit':
          stop_debug = true
        else # not a command, must be some Ruby code.
          code << line
        end
      end
    end # of debug_console

    # Client header.
    def display_header
      puts # spacer
      puts ''.center(WIDTH, '=')
      puts " Gambler v#{Gambler::VERSION} ".center(WIDTH, '=')
      puts ''.center(WIDTH, '=')
      puts '----------------------------------------'.center(WIDTH)
      puts '| Feeding yet another human addiction. |'.center(WIDTH)
      puts '----------------------------------------'.center(WIDTH)
    end # of display_header

    # Pretty print the player's stats.
    def display_player_stats
      puts '- Players -'.center(WIDTH)
      seperator = "\t"
      stat_width = WIDTH - 5
      stats     = String.new
      bot_stats = String.new

      stats << "Player: #{@player.name}".ljust(WIDTH/2)
      stats << seperator
      stats << "Chips: #{@player.chips}"
      puts stats.center(stat_width)

      if @bots.empty?
        puts 'No AI opponents.'.center(WIDTH)
      else
        @bots.each do |bot|
          bot_stats  = "AI: #{bot.name}".ljust(WIDTH/2)
          bot_stats << seperator
          bot_stats << "Chips: #{bot.chips}"
          puts bot_stats.center(stat_width)
        end
      end
    end # of display_player_stats

    # Client game menu.
    def display_game_menu
      puts '-----------------------'.center(WIDTH)
      puts '|  1) Blackjack       |'.center(WIDTH)
      puts '|  2) Stud Poker      |'.center(WIDTH)
      puts "|  3) Texas Hold 'em  |".center(WIDTH)
      puts '|  A) Add AI Player   |'.center(WIDTH)
      puts '|  D) Debug Console   |'.center(WIDTH)
      puts '|  P) Setup Player    |'.center(WIDTH)
      puts '|  Q) Quit            |'.center(WIDTH)
      puts '-----------------------'.center(WIDTH)
      puts
      print 'Game: '
    end # of display_menu

    # Display a menu for the Blackjack game.
    def display_blackjack_menu
      puts '----------------------------------------'.center(WIDTH)
      puts '| (B)et | (H)it | (S)tay | (V)iew Hand |'.center(WIDTH)
      puts '----------------------------------------'.center(WIDTH)
      puts
      print 'Command: '
    end

    # Play a quick game of Blackjack.
    def play_blackjack
      begin
        # Create an array and add the player and bots.
        players = Array.new
        players << @player
        players << @bots
        players.flatten!

        # Play the game!
        @game = Gambler::Game::Blackjack.new(:players => players)

        puts
        puts ''.center(WIDTH, '=')
        puts ' Blackjack '.center(WIDTH, '=')
        puts ''.center(WIDTH, '=')
        puts
        display_blackjack_menu

        # Game loop.
        loop do
          choice = STDIN.gets.chomp
          raise "Your choice was: #{choice}"
        end
      rescue Gambler::Exceptions::InvalidPlayerSize
        puts 'Need at least 2 players for blackjack.'
        until @bots.size >= 1
          @bots << setup_player(:bot => true)
        end
        retry
      end # of begin ZOMG!!1
    end # of play_blackjack

    # Takes an array of +code+ lines and <tt>eval</tt>'s them.
    def run_code(code)
      puts # spacer
      begin
        puts " BEGIN DEBUG ".center(WIDTH, '=')
        eval(code.join("\n")) # Need to join, since +code+ is an Array.
        puts " END DEBUG ".center(WIDTH, '=')
      rescue Exception => error
        puts " DEBUG FAILED ".center(WIDTH, '=')
        puts error
      end
      puts # spacer
    end

    # Setup a new Player instance.
    def setup_player(options = {})
      default_chips = 100
      if options[:bot]
        who = 'AI player'
        default_name = 'Kenny'
      else
        who = 'your player'
        default_name = 'Human'
      end

      puts "Setting up #{who}."
      print "Name [#{default_name}]: "
      name = STDIN.gets.chomp
      name = default_name if name.empty?

      print "Chips [#{default_chips}]: "
      chips = STDIN.gets.chomp.to_i
      chips = default_chips if chips.zero?

      return Gambler::Player.new(name, :chips => chips)
    end # of setup_player

    # Takes an array of +code+ lines and prints them.
    def show_code_buffer(code)
      return (puts "Buffer empty.") if code.size.zero?
      puts "== BUFFER ==\n"
      code.each_with_index do |buf, line_num|
        print "#{line_num + 1}:  ".rjust(5)
        puts buf
      end
    end

  end # of Client

end # of Gambler