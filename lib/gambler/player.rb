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
      raise NoPlayerName unless name
      @name  = name
      @hand  = options[:hand] || Array.new

      @chips = options[:chips] || CHIP_STACK
      raise InvalidChipCount unless @chips.is_a? Fixnum
    end

    # Pretty object inspection.
    def inspect
      %Q{#<Gambler::Player '#{@name}'>}
    end

    # Pretty printing of a Player.
    def to_s
      "#{@name} ($#{@chips})"
    end
  end # of Player

  class NoPlayerName < Exception; end
  class InvalidChipCount < Exception; end

end # of Gambler
