module Gambler

  module Game

    # The Game of Blackjack.
    class Blackjack < Gambler::Game::BasicGame
      INITIAL_CARDS = 2

      def initialize(options = {})
        raise Exceptions::InvalidPlayerSize unless options[:players].size >= 2
        super(options)
        @players.each { |player| player.empty_hand! }
        deal_initial_hands
      end

      # Forces each Player to put ante in the pot.
      def ante_up!
        @players.each { |player| place_bet(player, @ante) }
      end

      # Give +player+ a Card.
      def hit(player)
        @deck.deal_to player
      end

      # Allows +player+ to place a bet for +amount+ which will be added to
      # the current hand's pot.
      def place_bet(player, amount)
        raise Exceptions::NotEnoughChips if player.chips < amount
        @pot += amount
        player.chips -= amount
      end

      private

      # Deal out the initial cards to each Player.
      def deal_initial_hands
        INITIAL_CARDS.times do
          @players.each do |player|
            @deck.deal_to player
          end
        end
      end

    end # of Blackjack

  end # of Game

end # of Gambler
