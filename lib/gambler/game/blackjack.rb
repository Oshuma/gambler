module Gambler

  module Game

    # The Game of Blackjack.
    class Blackjack < Gambler::Game::BasicGame
      BUST = 21 # The hand_value in which the Player busts.
      INITIAL_CARDS = 2

      # These are used instead of Card::FACE_VALUES to accommodate Blackjack.
      FACE_VALUES = {
        'A' => 11,
        'K' => 10,
        'Q' => 10,
        'J' => 10,
        'T' => 10,
        '9' => 9,
        '8' => 8,
        '7' => 7,
        '6' => 6,
        '5' => 5,
        '4' => 4,
        '3' => 3,
        '2' => 2,
        'L' => 1 # Magic low Ace.
      }

      attr_reader :players_in_round
      attr_reader :round_winner

      def initialize(options = {})
        raise Exceptions::InvalidPlayerSize unless options[:players].size >= 2
        super(options)
        @players.each { |player| player.empty_hand! }
        @players_in_round = Array.new
        @players_in_round.replace(@players)
        @round_winner = nil
      end

      # Forces each Player to put ante in the pot.
      def ante_up!
        @players_in_round.each { |player| place_bet(player, @ante) }
      end

      # Calculates the integer value for a Blackjack +hand+.
      # Aces are converted to their lower value if the total hand value
      # will bust the Player (and there are aces in the +hand+, of course).
      def hand_value(hand)
        return 0 if hand.empty?
        value = 0

        # Add up the face values
        hand.each do |card|
          value += FACE_VALUES[card.face]
        end

        # Handle any needed Ace changes.
        while value > BUST
          hand.each do |card|
            if card.face == 'A'
              # Subtract the difference between high and low ace (10).
              value -= (FACE_VALUES['A'] - FACE_VALUES['L'])
            end
          end
          break # no aces to change, bail
        end

        return value
      end # of hand_value

      # Give +player+ a Card.
      def hit(player)
        @deck.deal_to player
        if player_bust?(player)
          @players_in_round.delete(player)
          raise Exceptions::PlayerBust
        end
      end

      # Allows +player+ to place a bet for +amount+ which will be added to
      # the current hand's pot.
      def place_bet(player, amount)
        raise Exceptions::NotEnoughChips if player.chips < amount
        @pot += amount
        player.chips -= amount
      end

      # Returns true of the Player's hand has a value above BUST.
      def player_bust?(player)
        hand_value(player.hand) > BUST
      end

      # This should be called at the beginning of every round (not game),
      # and sets up things like the ante and dealing initial hands.
      def start_round!
        @players.each { |player| player.empty_hand! }
        @players_in_round.replace(@players)
        @round_winner = nil
        ante_up!
        deal_initial_hands
      end

      # This should be called after all players bust or stay.  Sets the
      # <tt>@round_winner</tt> variable to the Player object who won and
      # gives them the pot.
      def finish_round!
        raise Exceptions::NoWinner if @players_in_round.nil?
        # The winner is the Player with the highest hand_value.
        @round_winner = @players_in_round.sort_by do |player|
          hand_value(player.hand)
        end.reverse.first
        @round_winner.chips += @pot
        @pot = INITIAL_POT
      end

      private

      # Deal out the initial cards to each Player.
      def deal_initial_hands
        INITIAL_CARDS.times do
          @players_in_round.each do |player|
            @deck.deal_to player
          end
        end
      end # of deal_initial_hands

    end # of Blackjack

  end # of Game

end # of Gambler
