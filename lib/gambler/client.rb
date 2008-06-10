require 'gambler/client/helper'

module Gambler

  # A simple Client which allows you to play around with Gambler.
  # This is *not* meant to be a full featured gaming application.
  # It only serves as an example of how you can use Gambler in your own code.
  class Client
    include ClientHelper

    # Global variable to detect when a Player is quitting the client.
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

  end # of Client

end # of Gambler
