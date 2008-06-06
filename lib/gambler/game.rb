require 'gambler/game/basic_game'
require 'gambler/game/blackjack'

module Gambler

  module Game
    class InvalidPlayers    < Exception; end
    class InvalidPlayerSize < Exception; end
    class NoPlayers         < Exception; end
  end # of Game

end # of Gambler
