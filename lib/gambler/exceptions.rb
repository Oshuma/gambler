module Gambler

  module Exceptions

    # Card
    class InvalidCardType < Exception; end

    # Deck
    class DeckEmpty   < Exception; end
    class InvalidDeck < Exception; end

    # Game
    class InvalidPlayers     < Exception; end
    class InvalidPlayerSize  < Exception; end
    class NoPlayers          < Exception; end
    class PlayNotImplemented < Exception; end

    # Player
    class NoPlayerName     < Exception; end
    class InvalidChipCount < Exception; end

  end # of Exceptions

end # of Gambler
