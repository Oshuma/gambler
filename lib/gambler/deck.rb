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
  #   Deck.new(:cards => Card.diamonds)
  class Deck
    DEFAULT_CARDS = Card.all
    DEFAULT_SIZE  = DEFAULT_CARDS.size

    attr_accessor :cards

    def initialize(options = {})
      options[:cards] ||= DEFAULT_CARDS
      options[:size]  ||= DEFAULT_SIZE

      options[:cards].each do |card|
        raise InvalidDeck unless card.is_a? Card
      end
      raise InvalidDeckSize unless options[:size].is_a? Fixnum

      @cards, @size = options[:cards], options[:size]
    end

    # Shuffles the Deck; changes <tt>@cards</tt> to reflect the shuffle.
    def shuffle!
      @cards.sort! {rand}
    end
  end # of Deck

  class InvalidDeck < Exception; end
  class InvalidDeckSize < Exception; end

end # of Gambler
