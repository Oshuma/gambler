module Gambler

  # Handles a Deck of Cards.  +options+ can be:
  # * <tt>cards</tt>: An array of Cards this Deck will contain.
  #
  # Examples:
  #
  # Using the defaults.
  #   Deck.new
  #
  # A Deck containing the specified +cards+; +size+ will be set to <tt>cards.size</tt>.
  #   Deck.new(:cards => Card.diamonds)
  class Deck
    attr_reader :cards, :shuffled

    def initialize(options = {})
      options[:cards] ||= Card.all
      options[:cards].each do |card|
        raise InvalidDeck unless card.is_a? Card
      end

      @cards = options[:cards]
      @shuffled = false
    end

    # Deals one Card to the given +player+.
    # Example:
    #   @deck.deal_to(@player)
    def deal_to(player)
      card = @cards.first
      raise DeckEmpty if card.nil?
      player.hand << card
      @cards.delete(card)
    end

    # Shuffles the Deck; changes <tt>@cards</tt> to reflect the shuffle.
    # Example:
    #   @deck.shuffle!
    def shuffle!
      @cards.sort! {rand}
      @shuffled = true
    end

    # Size of the current Deck (number of Cards remaining).
    def size
      @cards.size
    end
  end # of Deck

  class DeckEmpty   < Exception; end
  class InvalidDeck < Exception; end

end # of Gambler
