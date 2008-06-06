require File.dirname(__FILE__) + '/helper'

# Tests the Deck class.
class TestDeck < Test::Unit::TestCase
  def test_new_deck
    deck = Deck.new
    assert_kind_of(Deck, deck)
    assert_equal(52, deck.cards.size)
    assert_kind_of(Array, deck.cards)
    deck.cards.each do |card|
      assert_kind_of(Card, card)
    end
  end

  def test_invalid_cards
    assert_raise(InvalidDeck) do
      Deck.new(:cards => 'WTF')
    end
  end

  def test_invalid_deck_size
    assert_raise(InvalidDeckSize) do
      Deck.new(:size => 'WTF')
    end
  end

  def test_shuffle!
    deck = Deck.new
    first_card = deck.cards.first
    deck.shuffle!
    assert_not_equal(first_card, deck.cards.first)
  end
end
