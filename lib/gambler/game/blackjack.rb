module Gambler

  module Game

    # The Game of Blackjack.
    class Blackjack < Gambler::Game::BasicGame

      def initialize(options = {})
        raise InvalidPlayerSize unless options[:players].size >= 2
        super(options)
      end
    end # of Blackjack

  end # of Game

end # of Gambler
