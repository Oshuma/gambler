require File.dirname(__FILE__) + '/../helper'

# Test the BasicGame class.
class TestBasicGame < Test::Unit::TestCase
  include Game

  def setup
    @dale  = Player.new('Dale')
    @kenny = Player.new('Kenny')
    @game  = BasicGame.new(:players => [@dale, @kenny])
  end

  def test_basic_game_defaults
    assert_kind_of(BasicGame, @game)
    assert_equal(10, @game.ante)
    assert_equal(0, @game.pot)
    assert_kind_of(Deck, @game.deck)
    assert(@game.deck.shuffled, "#{@game.deck} is not shuffled!")
  end

  def test_no_players
    assert_raise(NoPlayers) do
      BasicGame.new(:players => []) # empty array
    end
  end

  def test_invalid_players
    assert_raise(InvalidPlayers) do
      BasicGame.new(:players => [@dale, 'WTF'])
    end
  end
end
