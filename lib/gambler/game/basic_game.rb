module Gambler

  module Game

    # The basic game class in which all others should inherit.
    # It gives some free functionality to it's children:
    # * <tt>players</tt>: Instance reader for the game's Players.
    # * <tt>ante</tt>: Instance accessor for the game's current ante.
    # * <tt>deck</tt>: Brand new, fully shuffled Deck to play with.
    # * <tt>pot</tt>: Instance accessor for the game's current pot.
    #
    # The +options+ hash only requires one element, +players+, which must
    # be an array of Gambler::Player objects.
    #
    # Example:
    #   class Poker < Gambler::Game::BasicGame
    #     def initialize(options = {})
    #       # ... do custom shit ...
    #       super(options)
    #     end
    #
    #     def poker_stuff
    #       !cheat
    #     end
    #   end
    #
    #   # Create some players.
    #   @dale  = Gambler::Player.new('Dale')
    #   @kenny = Gambler::Player.new('Kenny')
    #
    #   # This will be passed to Poker.new.
    #   options = {
    #     :players => [@dale, @kenny], # Only required option.
    #     :ante => 10,
    #     :pot => 1_000
    #   }
    #
    #   @game = Poker.new(options)
    class BasicGame
      INITIAL_ANTE = 10
      INITIAL_POT  = 0

      attr_reader :players
      attr_accessor :ante, :deck, :pot

      def initialize(options = {})
        raise NoPlayers unless options[:players].size > 0
        options[:players].each do |player|
          raise InvalidPlayers unless player.is_a? Player
        end
        @players = options[:players]

        @deck = Deck.new
        3.times { @deck.shuffle! }

        @ante = options[:ante] || INITIAL_ANTE
        @pot  = options[:pot]  || INITIAL_POT
      end
    end # of BasicGame

  end # of Game

end # of Gambler
