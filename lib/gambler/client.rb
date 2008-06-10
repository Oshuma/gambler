require 'gambler/client/helper'

module Gambler

  # A simple Client which allows you to play around with Gambler.
  # Most of this class can be ignored, as it just sets up the gaming
  # environment.  The method to pay attention to is +play_blackjack+.
  # This is the method that actually creates and deals a Blackjack game.
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
