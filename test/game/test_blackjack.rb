require File.dirname(__FILE__) + '/../helper'

# Test the Blackjack class.
class TestBlackjack < Test::Unit::TestCase
  include Game

  def setup
    @dale  = Player.new('Dale')
    @kenny = Player.new('Kenny')
    @game = Blackjack.new(:players => [@dale, @kenny])
  end

  def test_new_blackjack_game
    assert_kind_of(Blackjack, @game)
    assert_equal(10, @game.ante)
    assert_equal(0, @game.pot)
    assert_kind_of(Deck, @game.deck)
  end

  def test_invalid_player_size
    assert_raise(InvalidPlayerSize) do
      Blackjack.new(:players => [])
      Blackjack.new(:players => [@dale])
    end
  end
end
