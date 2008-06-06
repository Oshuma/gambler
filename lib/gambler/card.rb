module Gambler

  # Object representing an individual Card.
  #
  # Example:
  #   Card.new ['K', 'd']
  #   Card.new :face => 'K', :suit => 'd'
  #   Card.new 'Kd'
  #
  # All of the above lines create a king of diamonds.
  class Card
    SUITS = %w(c d h s)
    SUIT_NAMES = {
      'c' => 'Clubs',
      'd' => 'Diamonds',
      'h' => 'Hearts',
      's' => 'Spades'
    }

    FACES = %w(A K Q J T 9 8 7 6 5 4 3 2)
    FACE_NAMES = {
      'A' => 'Ace',
      'K' => 'King',
      'Q' => 'Queen',
      'J' => 'Jack',
      'T' => 'Ten',
      '9' => 'Nine',
      '8' => 'Eight',
      '7' => 'Seven',
      '6' => 'Six',
      '5' => 'Five',
      '4' => 'Four',
      '3' => 'Three',
      '2' => 'Two'
    }
    FACE_VALUES = {
      'A' => 14,
      'K' => 13,
      'Q' => 12,
      'J' => 11,
      'T' => 10,
      '9' => 9,
      '8' => 8,
      '7' => 7,
      '6' => 6,
      '5' => 5,
      '4' => 4,
      '3' => 3,
      '2' => 2,
      'X' => 1 # Magic low Ace.  Not used.
    }

    attr_reader :face, :suit

    # Creates a new Card object, based on the class of +args+.
    def initialize(args)
      face, suit = case args
      when Array:
        build_from_array(args)
      when Hash:
        build_from_hash(args)
      when String:
        build_from_string(args)
      end
      raise InvalidCardType unless SUITS.include?(suit) && FACES.include?(face)
      @face, @suit = face, suit
    end

    # Class methods.
    class << self
      # Iterator for all Cards; yields one Card in +block+ or returns an Array of all Cards.
      def all(&block)
        cards = Array.new
        each_suit do |suit|
          each_face do |face|
            if block_given?
              yield new(:face => face, :suit => suit)
            else
              cards << new(:face => face, :suit => suit)
            end
          end
        end
        return cards
      end

      # Iterator for the FACES.
      def each_face(&block)
        FACES.each { |face| yield face }
      end # of each_face

      # Iterator for the SUITS.
      def each_suit(&block)
        SUITS.each { |suit| yield suit }
      end # of each_suit

      # Build methods for each SUIT which will return an array of all Cards in that SUIT.
      # This will allow for things like:
      #   Card.diamonds.sort_by { |card| card.face_value }.each {|card| puts card}
      class_eval do
        Card.each_suit do |index|
          suit_name = SUIT_NAMES[index].downcase
          define_method(suit_name) do
            cards = Array.new
            all do |card|
              cards << card if card.suit == index
            end
            return cards
          end
        end # of Card.each_suit
      end # of class_eval
    end # of class methods

    # Return the numerical face value of a Card.
    def face_value
      FACE_VALUES[@face]
    end

    # Print a human readable description.
    def to_s
      face = FACE_NAMES[@face]
      suit = SUIT_NAMES[@suit]
      return "#{face} of #{suit}"
    end

    private

    # Build a Card object with the given +array+.
    # Example:
    #   build_from_array ['K', 'd']
    def build_from_array(array)
      raise InvalidCardType unless array.size == 2
      face = array.shift
      suit = array.shift
      return face, suit
    end

    # Build a Card object with the given +hash+.
    # Example:
    #   build_from_hash(:face => 'K', :suit => 'd')
    def build_from_hash(hash)
      raise InvalidCardType unless hash.include?(:face) && hash.include?(:suit)
      return hash[:face], hash[:suit]
    end

    # Build a Card object with the given +string+.
    # Example:
    #   build_from_string('Kd')
    def build_from_string(string)
      card = string.split('')
      raise InvalidCardType unless card.size == 2
      face = card.shift # First letter.
      suit = card.shift # Second letter.
      return face, suit
    end
  end # of Card

  class InvalidCardType < Exception; end

end # of Gambler
