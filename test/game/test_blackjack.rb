require File.dirname(__FILE__) + '/../helper'

# Test the Blackjack class.
class TestBlackjack < Test::Unit::TestCase
  include Game

  def setup
    @dale  = Player.new('Dale')
    @kenny = Player.new('Kenny')
    @game = Blackjack.new(:players => [@dale, @kenny])
    @game.start_round!
  end

  def test_new_blackjack_game
    assert_kind_of(Blackjack, @game)
    assert_equal(10, @game.ante)
    assert_equal(20, @game.pot)
    assert_kind_of(Deck, @game.deck)
  end

  def test_invalid_player_size
    assert_raise(InvalidPlayerSize) do
      Blackjack.new(:players => [])
      Blackjack.new(:players => [@dale])
    end
  end

  def test_ante_up!
    @game.ante_up!
    assert_equal(40, @game.pot)
  end

  def test_hand_value
    @player = Player.new('Newb', :hand => [ Card.new('2s'), Card.new('3s') ])
    assert_equal(5, @game.hand_value(@player.hand))
  end

  def test_hand_value_with_aces
    @player = Player.new('Newb', :hand => [
      Card.new('As'), Card.new('2s'), Card.new('3s') ])
    assert_equal(16, @game.hand_value(@player.hand))
  end

  def test_hand_value_treating_ace_as_one
    @player = Player.new('Newb', :hand => [
      Card.new('As'), Card.new('2s'), Card.new('Ks') ])
    assert_equal(13, @game.hand_value(@player.hand))
  end

  def test_hit
    @game.hit(@dale)
    assert_equal(3, @dale.hand.size)
  end

  def test_place_bet
    @game.place_bet(@dale, 10)
    assert_equal(30, @game.pot)
  end

  def test_player_bust?
    @dale.hand = [ Card.new('Kd'), Card.new('Qd') ]
    assert_raise(Exceptions::PlayerBust) do
      @game.hit @dale
    end
  end
end
