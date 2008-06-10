# Add the Gambler library path to the front of the Ruby load path.
$LOAD_PATH.unshift File.dirname(__FILE__)

# Third party libraries.
require 'rubygems'

# Gambler libraries.
require 'gambler/card'
require 'gambler/client'
require 'gambler/deck'
require 'gambler/exceptions'
require 'gambler/game'
require 'gambler/player'

module Gambler
  include Exceptions

  class << self
    attr_accessor :debug
  end

  self.debug = false

  VERSION = '0.0.2'
end
