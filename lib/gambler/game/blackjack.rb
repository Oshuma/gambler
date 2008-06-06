module Gambler

  module Game

    # The Game of Blackjack.
    class Blackjack < Gambler::Game::BasicGame
      INITIAL_CARDS = 2

      def initialize(options = {})
        raise Exceptions::InvalidPlayerSize unless options[:players].size >= 2
        super(options)
        @players.each { |player| player.empty_hand! }
      end

      # This is what sets the game in motion.
      def play
        deal_initial_cards
      end # of play

      private

      # Deal out the initial cards.
      def deal_initial_cards
        INITIAL_CARDS.times do
          @players.each do |player|
            @deck.deal_to player
          end
        end
      end

    end # of Blackjack

  end # of Game

end # of Gambler
