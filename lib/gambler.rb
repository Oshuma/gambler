# Add the Gambler library path to the front of the Ruby load path.
$LOAD_PATH.unshift File.dirname(__FILE__)

# Third party libraries.
require 'rubygems'

# Gambler libraries.
require 'gambler/player'

module Gambler
  class << self
    attr_accessor :debug
  end

  self.debug = false

  VERSION = '0.0.1'
end
