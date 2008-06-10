module Gambler

  # Helpful methods used in Gambler::Client.
  module ClientHelper
    # Various headers will be centered with WIDTH.
    WIDTH = 50

    # Add an AI Player as an opponent.
    def add_ai_player
      @bots << setup_player(:bot => true)
    end

    # Simple debugging console.
    def debug_console
      stop_debug = false
      code = Array.new

      @output.puts # spacer
      @output.puts '== DEBUG CONSOLE =='
      @output.puts 'Commands:'
      @output.puts '  /run  - Quit debugger and run the code.'
      @output.puts '  /show - Show the code currently in the buffer.'
      @output.puts '  /quit - Quit debugger without running the code.'

      until stop_debug do
        @output.print "eval:#{code.size + 1}> "
        line = @input.gets.chomp

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
      @output.puts # spacer
      @output.puts ''.center(WIDTH, '=')
      @output.puts " Gambler v#{Gambler::VERSION} ".center(WIDTH, '=')
      @output.puts ''.center(WIDTH, '=')
      @output.puts '----------------------------------------'.center(WIDTH)
      @output.puts '| Feeding yet another human addiction. |'.center(WIDTH)
      @output.puts '----------------------------------------'.center(WIDTH)
    end # of display_header

    # Pretty print the player's stats.
    def display_player_stats
      @output.puts '- Players -'.center(WIDTH)
      seperator = "\t"
      stat_width = WIDTH - 5
      stats     = String.new
      bot_stats = String.new

      stats << "Player: #{@player.name}".ljust(WIDTH/2)
      stats << seperator
      stats << "Chips: #{@player.chips}"
      @output.puts stats.center(stat_width)

      if @bots.empty?
        @output.puts 'No AI opponents.'.center(WIDTH)
      else
        @bots.each do |bot|
          bot_stats  = "AI: #{bot.name}".ljust(WIDTH/2)
          bot_stats << seperator
          bot_stats << "Chips: #{bot.chips}"
          @output.puts bot_stats.center(stat_width)
        end
      end
    end # of display_player_stats

    # Client game menu.
    def display_game_menu
      @output.puts '-----------------------'.center(WIDTH)
      @output.puts '|  1) Blackjack       |'.center(WIDTH)
      @output.puts '|  2) Stud Poker      |'.center(WIDTH)
      @output.puts "|  3) Texas Hold 'em  |".center(WIDTH)
      @output.puts '|  A) Add AI Player   |'.center(WIDTH)
      @output.puts '|  D) Debug Console   |'.center(WIDTH)
      @output.puts '|  P) Setup Player    |'.center(WIDTH)
      @output.puts '|  Q) Quit            |'.center(WIDTH)
      @output.puts '-----------------------'.center(WIDTH)
      @output.puts
      @output.print 'Game: '
    end # of display_menu

    # Display a menu for the Blackjack game.
    def display_blackjack_menu
      @output.puts '----------------------------------------'.center(WIDTH)
      @output.puts '| (B)et | (H)it | (S)tay | (V)iew Hand |'.center(WIDTH)
      @output.puts '----------------------------------------'.center(WIDTH)
      @output.puts
      @output.print 'Command: '
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

        @output.puts
        @output.puts ''.center(WIDTH, '=')
        @output.puts ' Blackjack '.center(WIDTH, '=')
        @output.puts ''.center(WIDTH, '=')
        @output.puts
        display_blackjack_menu

        # Game loop.
        loop do
          choice = @input.gets.chomp
          raise "Your choice was: #{choice}"
        end
      rescue Gambler::Exceptions::InvalidPlayerSize
        @output.puts 'Need at least 2 players for blackjack.'
        until @bots.size >= 1
          @bots << setup_player(:bot => true)
        end
        retry
      end # of begin ZOMG!!1
    end # of play_blackjack

    # Takes an array of +code+ lines and <tt>eval</tt>'s them.
    def run_code(code)
      @output.puts # spacer
      begin
        @output.puts " BEGIN DEBUG ".center(WIDTH, '=')
        eval(code.join("\n")) # Need to join, since +code+ is an Array.
        @output.puts " END DEBUG ".center(WIDTH, '=')
      rescue Exception => error
        @output.puts " DEBUG FAILED ".center(WIDTH, '=')
        @output.puts error
      end
      @output.puts # spacer
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

      @output.puts "Setting up #{who}."
      @output.print "Name [#{default_name}]: "
      name = @input.gets.chomp
      name = default_name if name.empty?

      @output.print "Chips [#{default_chips}]: "
      chips = @input.gets.chomp.to_i
      chips = default_chips if chips.zero?

      return Gambler::Player.new(name, :chips => chips)
    end # of setup_player

    # Takes an array of +code+ lines and prints them.
    def show_code_buffer(code)
      return (@output.puts "Buffer empty.") if code.size.zero?
      @output.puts "== BUFFER ==\n"
      code.each_with_index do |buf, line_num|
        @output.print "#{line_num + 1}:  ".rjust(5)
        @output.puts buf
      end
    end

  end # of ClientHelper

end # of Gambler
