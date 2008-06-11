module Gambler

  module Exceptions

    # Gambler
    class MustOverrideMethod < Exception; end

    # Card
    class InvalidCardType < Exception; end

    # Deck
    class DeckEmpty   < Exception; end
    class InvalidDeck < Exception; end

    # Game
    class InvalidPlayers     < Exception; end
    class InvalidPlayerSize  < Exception; end
    class NotEnoughChips     < Exception; end
    class NoPlayers          < Exception; end

    # Player
    class NoPlayerName     < Exception; end
    class InvalidChipCount < Exception; end

  end # of Exceptions

end # of Gambler
