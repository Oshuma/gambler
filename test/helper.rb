require 'test/unit'

unless defined? Gambler
  require File.join(File.dirname(__FILE__), *%w[ .. lib gambler ])
  include Gambler
end

def fixture(name)
  File.read(File.join(File.dirname(__FILE__), 'fixtures', name))
end unless defined?(:fixture)
