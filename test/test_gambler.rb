require File.dirname(__FILE__) + '/helper'

# Tests the Gambler module.
class TestGambler < Test::Unit::TestCase
  def test_version_string
    assert_equal(Gambler::VERSION, '0.0.2')
  end
  
  def test_debug
    assert_equal(Gambler.debug, false)
    Gambler.debug = true
    assert_equal(Gambler.debug, true)
  end
end
