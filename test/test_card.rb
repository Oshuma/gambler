require File.dirname(__FILE__) + '/helper'

# Tests the Card class.
class TestCard < Test::Unit::TestCase
  def test_all_cards
    assert_equal(52, Card.all.size)
    assert_kind_of(Array, Card.all)
  end

  def test_all_iterator
    Card.all do |card|
      assert_kind_of(Card, card)
      assert(Card::FACES.include?(card.face), "#{card.face} was not found in FACES.")
      assert(Card::SUITS.include?(card.suit), "#{card.suit} was not found in SUITS.")
    end
  end

  def test_each_face
    Card.each_face do |face|
      assert(Card::FACES.include?(face), "#{face} was not found in FACES.")
    end
  end

  def test_each_suit
    Card.each_suit do |suit|
      assert(Card::SUITS.include?(suit), "#{suit} was not found in SUITS.")
    end
  end

  def test_clubs_class_method
    clubs = Card.clubs
    assert_kind_of(Array, clubs)
    clubs.each do |card|
      assert_kind_of(Card, card)
      assert_equal('c', card.suit)
    end
  end

  def test_diamonds_class_method
    diamonds = Card.diamonds
    assert_kind_of(Array, diamonds)
    diamonds.each do |card|
      assert_kind_of(Card, card)
      assert_equal('d', card.suit)
    end
  end

  def test_hearts_class_method
    hearts = Card.hearts
    assert_kind_of(Array, hearts)
    hearts.each do |card|
      assert_kind_of(Card, card)
      assert_equal('h', card.suit)
    end
  end

  def test_spades_class_method
    spades = Card.spades
    assert_kind_of(Array, spades)
    spades.each do |card|
      assert_kind_of(Card, card)
      assert_equal('s', card.suit)
    end
  end

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
