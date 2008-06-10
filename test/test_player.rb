require File.dirname(__FILE__) + '/helper'

# Tests the Player class.
class TestPlayer < Test::Unit::TestCase
  def setup
    @player = Player.new('Dale')
  end

  def test_pretty_inspect
    assert_equal("#<Gambler::Player 'Dale'>", @player.inspect)
  end

  def test_to_s
    assert_equal('Dale ($100)', @player.to_s)
  end

  def test_new_player
    dale = Player.new('Dale', :chips => 10) # broke :(
    assert_kind_of(Player, dale)
    assert_equal('Dale', dale.name)
    assert_equal(10, dale.chips)
    assert(dale.hand.empty?)
  end

  def test_player_name
    @player = Player.new('Dale')
    assert_equal('Dale', @player.name)
  end

  def test_no_player_name
    assert_raise(ArgumentError) { Player.new }
  end

  def test_change_name
    @player.name = 'Not Dale'
    assert_equal('Not Dale', @player.name)
  end

  def test_player_hand
    assert(@player.hand.empty?)
    @player = Player.new( 'Cheaty McGee', # has blackjack from the start!
                          :hand => [Card.new('Ad'), Card.new('Kd')] )
    assert_equal(2, @player.hand.size)
  end

  def test_empty_hand!
    @player = Player.new('Dale', :hand => [Card.new('Ad'), Card.new('Kd')])
    assert_equal(2, @player.hand.size)
    @player.empty_hand!
    assert_equal(0, @player.hand.size)
  end

  def test_view_hand_as_array
    @player = Player.new('Dale', :hand => [Card.new('Ad'), Card.new('Kd')])
    assert_equal(['Ad', 'Kd'], @player.view_hand) # defaults to non-pretty array.
  end

  def test_view_hand_as_pretty_array
    @player = Player.new('Dale', :hand => [Card.new('Ad'), Card.new('Kd')])
    pretty_hand = ['Ace of Diamonds', 'King of Diamonds']
    assert_equal(pretty_hand, @player.view_hand(:format => :array, :pretty => true))
  end

  def test_view_hand_as_string
    @player = Player.new('Dale', :hand => [Card.new('Ad'), Card.new('Kd')])
    assert_equal('Ad Kd', @player.view_hand(:format => :string))
  end

  def test_view_hand_as_pretty_string
    @player = Player.new('Dale', :hand => [Card.new('Ad'), Card.new('Kd')])
    pretty_hand = 'Ace of Diamonds, King of Diamonds'
    assert_equal(pretty_hand, @player.view_hand(:format => :string, :pretty => true))
  end

  def test_default_chip_stack
    assert_equal(100, @player.chips)
  end

  def test_player_chips
    @player = Player.new('Dale', :chips => 500)
    assert_equal(500, @player.chips)
  end

  def test_invalid_chip_count
    assert_raise(InvalidChipCount) do
      Player.new('Dale', :chips => 'WTF')
    end
  end

  def test_change_chip_count
    pot = 1_000_000_000
    chips = @player.chips
    @player.chips += pot # You win!
    assert_equal(pot + chips, @player.chips)
  end

  def test_is_broke?
    @player.chips = 0
    assert(@player.is_broke?, "#{@player} isn't broke")
  end

  def test_is_not_broke
    assert_equal(100, @player.chips)
    assert_equal(false, @player.is_broke?)
  end
end
