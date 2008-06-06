module Gambler

  module Game

    # The Game of Blackjack.
    class Blackjack < Gambler::Game::BasicGame
      def initialize(options = {})
        raise Exceptions::InvalidPlayerSize unless options[:players].size >= 2
        super(options)
      end

      # This is what sets the game in motion.
      def play
        raise "Pretend we're playing."
      end # of play

    end # of Blackjack

  end # of Game

end # of Gambler
