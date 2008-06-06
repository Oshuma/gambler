module Gambler

  # Main Player class in which all others should inherit.
  class Player
    # Initial chip count if none is specified.
    CHIP_STACK = 100

    attr_accessor :name, :chips

    def initialize(options = {})
      raise NoPlayerName unless options[:name]
      @name  = options[:name]
      @chips = options[:chips] || CHIP_STACK
      raise InvalidChipCount unless @chips.is_a? Fixnum
    end

    # Pretty object inspection.
    def inspect
      %Q{#<Gambler::Player '#{@name}'>}
    end
  end # Player

  class NoPlayerName < Exception; end
  class InvalidChipCount < Exception; end

end # Gambler
