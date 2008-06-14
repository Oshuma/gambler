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
        @output.print "debug:#{code.size + 1}> "
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

    # Prints all Player hands.
    def display_hands
      @output.puts '--'
      @output.puts "|  Pot: $#{@game.pot}"
      @output.puts "| Ante: $#{@game.ante}"
      @output.puts '--'

      @output.puts @player
      @output.puts "#{@player.view_hand(:format => :string)}".rjust(5)

      @bots.each do |bot|
        @output.puts ''.center(WIDTH, '-')
        @output.puts bot
        # Hide the first card for all bots.  No cheating!
        public_hand = bot.view_hand.reject do |c|
          c == bot.view_hand.first
        end.join(' ')
        @output.puts "** #{public_hand}".rjust(5)
      end
    end # of display_hands

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
      @output.puts # spacer
      @output.print 'Command: '
    end # of display_menu

    # Display a menu for the Blackjack game.
    def display_blackjack_menu
      @output.puts # spacer
      @output.puts '--------------------------'.center(WIDTH)
      @output.puts '| (B)et | (H)it | (S)tay |'.center(WIDTH)
      @output.puts '--------------------------'.center(WIDTH)
      @output.puts '----------------------------------'.center(WIDTH)
      @output.puts '| (D)ebug | (M)ain Menu | (Q)uit |'.center(WIDTH)
      @output.puts '----------------------------------'.center(WIDTH)
      @output.puts # spacer
      @output.print 'Command: '
    end

    # Play a quick game of Blackjack.
    def play_blackjack
      # This block creates the players array and the game instance.
      begin
        players = Array.new
        players << @player
        players << @bots
        players.flatten!
        @game = Gambler::Game::Blackjack.new(:players => players)
        @game.start_round!
      rescue Gambler::Exceptions::InvalidPlayerSize
        @output.puts 'Need at least 2 players for blackjack.'
        until @bots.size >= 1
          @bots << setup_player(:bot => true)
        end
        retry
      end

      @output.puts # spacer
      @output.puts ''.center(WIDTH, '=')
      @output.puts ' Blackjack '.center(WIDTH, '=')
      @output.puts ''.center(WIDTH, '=')
      @output.puts # spacer

      # Main game loop.
      loop do
        display_hands
        display_blackjack_menu

        choice = @input.gets.chomp
        case choice
        when /b/i: # Bet
          begin
            print 'Amount: '
            amount = @input.gets.chomp.to_i
            @game.place_bet(@player, amount)
          rescue Gambler::Exceptions::NotEnoughChips
            @output.puts "You only have $#{@player.chips} left!"
            retry
          end
        when /h/i:
          begin
            @game.hit(@player)
            raise Gambler::Exceptions::PlayerBusted if @game.player_bust?(@player)
          rescue Gambler::Exceptions::PlayerBusted
            @output.puts 'BUST!'
            # .. next hand ..
          end
        when /s/i: # Stay
          play_bot_hands
        when /d/i: debug_console
        when /m/i: break # Return to main menu.
        when /q/i: # Quit the Client.
          $player_quits = true
          break # from this loop
        else
          @output.puts 'Invalid choice, dumbass.'
        end # of case
      end # of main game loop.
    end # of play_blackjack

    # Loops through the <tt>@bots</tt> and plays their hand (with some shoddy AI, mind you).
    def play_bot_hands
      @bots.each do |bot|
        while @game.hand_value(bot.hand) <= 17
          begin
            @game.hit(bot)
            @output.puts "#{bot} signals for a hit and gets a #{bot.hand.last}"
            raise Gambler::Exceptions::PlayerBusted if @game.player_bust?(bot)
          rescue Gambler::Exceptions::PlayerBusted
            @output.puts "#{bot} has busted!"
            # .. remove bot from current round ..
          end
        end
      end
    end # of play_bot_hands

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
