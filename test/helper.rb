require 'test/unit'

unless defined? Gambler
  require File.join(File.dirname(__FILE__), *%w[ .. lib gambler ])
  include Gambler
end
