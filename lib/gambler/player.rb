module Gambler

  # Main Player class in which all others should inherit (if neccessary).
  # The Player's +name+ is required.
  #
  # +options+ can contain:
  # * <tt>chips</tt>: Amount of chips the new Player will have.  Defaults to 100.
  # * <tt>hand</tt>: An array of Cards the new Player will be holding.  Defaults to +nil+.
  #
  # Example:
  #   Player.new('Dale')
  #   Player.new('Kenny', :chips => 1_000_000)
  #   Player.new( 'Cheaty McGee', # has blackjack from the start!
  #               :hand => [Card.new('Ad'), Card.new('Kd')] )
  class Player
    # Initial chip count if none is specified.
    CHIP_STACK = 100

    attr_accessor :name, :chips, :hand

    def initialize(name, options = {})
      raise Exceptions::NoPlayerName unless name
      @name  = name
      @hand  = options[:hand] || Array.new

      @chips = options[:chips] || CHIP_STACK
      raise Exceptions::InvalidChipCount unless @chips.is_a? Fixnum
    end

    # Removes all the Cards from the Player's hand.
    def empty_hand!
      @hand = Array.new
    end

    # Pretty object inspection.
    def inspect
      %Q{#<Gambler::Player '#{@name}'>}
    end

    # Return true/false depending on if the Player has chips.
    def is_broke?
      @chips <= 0
    end

    # Pretty printing of a Player.
    def to_s
      "#{@name} ($#{@chips})"
    end

    # Allows a Player to view their +hand+ in various formats.
    # Examples:
    #   @player = Player.new('Dale', :hand => [Card.new('Ad'), Card.new('Kd')])
    #
    #   # :format => :array (the default)
    #   @player.view_hand
    #   => ['Ad', 'Kd']
    #   @player.view_hand(:pretty => true)
    #   => ['Ace of Diamonds', 'King of Diamonds']
    #
    #   # :format => :string
    #   @player.view_hand(:format => :string)
    #   => 'Ad Kd'
    #   @player.view_hand(:format => :string, :pretty => true)
    #   => 'Ace of Diamonds, King of Diamonds'
    #   @player.view_hand(:format => :string, :pretty => true, :seperator => ' | ')
    #   => 'Ace of Diamonds | King of Diamonds'
    def view_hand(options = {})
      format    = options[:format]    || :array
      pretty    = options[:pretty]    || false
      seperator = options[:seperator] || (pretty ? ', ' : ' ')

      method = (pretty ? :to_pretty_s : :to_s)

      case format
      when :array
        cards = Array.new
        @hand.each { |card| cards << card.send(method) }
      when :string
        cards = @hand.collect { |card| card.send(method) }.join(seperator)
      end
      return cards
    end # of view_hand

  end # of Player
end # of Gambler
