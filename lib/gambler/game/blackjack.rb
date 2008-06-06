module Gambler

  module Game

    # The Game of Blackjack.
    #
    # Example:
    #   @dale  = Player.new('Dale')
    #   @kenny = Player.new('Kenny')
    #   options = {
    #     :players => [@dale, @kenny],
    #     :ante => 10,
    #     :pot => 1_000
    #   }
    #   Blackjack.new(options)
    class Blackjack
      INITIAL_ANTE = 10
      INITIAL_POT  = 0

      attr_reader :players
      attr_accessor :ante, :deck, :pot

      def initialize(options = {})
        raise InvalidPlayerSize unless options[:players].size >= 2
        @players = options[:players]
        @deck = Deck.new
        3.times { @deck.shuffle! }
        @ante = options[:ante] || INITIAL_ANTE
        @pot  = options[:pot]  || INITIAL_POT
      end
    end # of Blackjack

  end # of Game

end # of Gambler
