module Gambler

  # Handles a Deck of Cards.
  #
  # Examples:
  #
  # Using the defaults.
  #   Deck.new
  #
  # A Deck with 20 random cards.
  #   Deck.new(:size => 20)
  #
  # A Deck containing the specified +cards+; +size+ will be set to <tt>cards.size</tt>.
  #   Deck.new(:cards => ['As', 'Ks', 'Qs', 'Js', 'Ts'])
  #
  # A Deck containing diamonds only.
  #   Deck.new(:cards => :diamonds)
  class Deck
    def initialize()
    end
  end # of Deck

end # of Gambler
