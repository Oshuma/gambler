require 'test/unit'

require File.join(File.dirname(__FILE__), *%w[ .. lib gambler ])
include Gambler

def fixture(name)
  File.read(File.join(File.dirname(__FILE__), 'fixtures', name))
end