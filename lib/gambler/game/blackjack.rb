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

      # Calculates the integer value for a Blackjack +hand+.
      def hand_value(hand)
        return 0 if hand.empty?
        hand_value = 0
        hand.each do |card|
          hand_value += (card.face_value >= 10 ? 10 : card.face_value)
        end
        return hand_value
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

      # Returns true of the Player's hand has a value above 21.
      def player_bust?(player)
        hand_value(player.hand) > 21
        # calculate Aces?
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
