require File.dirname(__FILE__) + '/helper'

# Tests the Player class.
class TestPlayer < Test::Unit::TestCase
  def test_player_name
    @player = Player.new(:name => 'Dale')
    assert_equal('Dale', @player.name)
  end
  
  def test_no_player_name
    assert_raise(NoPlayerName) { Player.new }
  end
  
  def test_player_chips
    @player = Player.new(:name => 'Dale', :chips => 500)
    assert_equal(500, @player.chips)
  end
  
  def test_invalid_chip_count
    assert_raise(InvalidChipCount) do
      Player.new(:name => 'Dale', :chips => 'WTF')
    end
  end
end