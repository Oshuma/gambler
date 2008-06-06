require File.dirname(__FILE__) + '/helper'

# Tests the Deck class.
class TestDeck < Test::Unit::TestCase
  def test_new_deck
    assert_kind_of(Deck, Deck.new)
  end
end
