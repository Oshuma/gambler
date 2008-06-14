module Gambler

  module Game

    # The basic game class in which all others can inherit.
    # Feel free to create your own game class which does not inherit
    # from BasicGame, but uses Player, Deck, etc. directly.
    #
    # BasicGame gives some free functionality to it's children:
    # * <tt>players</tt>: Instance reader for the game's Player(s).
    # * <tt>ante</tt>: Instance accessor for the game's current ante.
    # * <tt>deck</tt>: Brand new, fully shuffled Deck to play with.
    # * <tt>pot</tt>: Instance accessor for the game's current pot.
    #
    # The +options+ hash only requires one element, +players+, which must
    # be an array of Gambler::Player object(s).
    #
    # Example:
    #   class Poker < Gambler::Game::BasicGame
    #     def initialize(options = {})
    #       # .. do custom shit (if needed) ..
    #       super(options) # Required to recieve free functionality.
    #       # .. more custom shit (if needed) ..
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
    #     :players => [@dale, @kenny], # The only required option.
    #     :ante => 50,
    #     :pot => 1_000
    #   }
    #
    #   @game = Poker.new(options)
    #   @game.poker_stuff
    class BasicGame
      INITIAL_ANTE = 10
      INITIAL_POT  = 0

      attr_reader :players
      attr_accessor :ante, :deck, :pot

      def initialize(options = {})
        raise Exceptions::NoPlayers unless options[:players].size > 0
        options[:players].each do |player|
          raise Exceptions::InvalidPlayers unless player.is_a? Player
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
