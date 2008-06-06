module Gambler

  # Handles a collection of Gambler::Card objects as a single Deck.
  # +options+ can be:
  # * <tt>cards</tt>: An array of Cards this Deck will contain.
  #
  # Examples:
  #
  #   @deck = Deck.new
  class Deck
    attr_reader :cards, :shuffled

    def initialize(options = {})
      options[:cards] ||= Card.all
      options[:cards].each do |card|
        raise Exceptions::InvalidDeck unless card.is_a? Card
      end

      @cards = options[:cards]
      @shuffled = false
    end

    # Deals one Card to the given +player+.
    # Example:
    #   @deck.deal_to(@player)
    def deal_to(player)
      card = @cards.first
      raise Exceptions::DeckEmpty if card.nil?
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
end # of Gambler
