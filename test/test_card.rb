require File.dirname(__FILE__) + '/helper'

# Tests the Card class.
class TestCard < Test::Unit::TestCase
  def test_to_s
    card = Card.new(:face => 'K', :suit => 'd')
    assert_equal('King of Diamonds', card.to_s)
  end

  def test_new_card_from_array
    card = %w{ K d }
    assert_kind_of(Card, Card.new(card))
  end

  def test_new_card_from_hash
    card = { :face => 'K', :suit => 'd' }
    assert_kind_of(Card, Card.new(card))
  end

  def test_new_card_from_string
    card = 'Kd'
    assert_kind_of(Card, Card.new(card))
  end

  def test_invalid_card_initializer
    assert_raise(InvalidCardType) { Card.new(420) }
  end

  def test_invalid_card_from_hash
    assert_raise(InvalidCardType) { Card.new(:wtf => 'ZOMG') }
  end

  def test_invalid_card_from_string
    assert_raise(InvalidCardType) { Card.new('WTF') }
  end
end
