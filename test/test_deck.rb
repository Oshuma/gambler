require File.dirname(__FILE__) + '/helper'

# Tests the Deck class.
class TestDeck < Test::Unit::TestCase
  def setup
    @deck = Deck.new
    @dale  = Player.new('Dale')
    @kenny = Player.new('Kenny')
  end

  def test_new_deck
    new_deck = Deck.new
    assert_kind_of(Deck, new_deck)
    assert_equal(false, new_deck.shuffled)
    assert_equal(52, new_deck.size)
    assert_kind_of(Array, new_deck.cards)
    new_deck.cards.each do |card|
      assert_kind_of(Card, card)
    end
  end

  def test_cards_option
    new_deck = Deck.new(:cards => Card.diamonds)
    assert_kind_of(Deck, new_deck)
    assert_equal(Card.diamonds.size, new_deck.size)
    new_deck.cards.each do |card|
      assert_equal('d', card.suit)
    end
  end

  def test_invalid_cards
    assert_raise(InvalidDeck) do
      Deck.new(:cards => 'WTF')
    end
  end

  def test_shuffle!
    first_card = @deck.cards.first
    last_card  = @deck.cards.last
    @deck.shuffle!
    assert(@deck.shuffled, "#{@deck} not shuffled!")
    assert_not_equal(first_card, @deck.cards.first)
    assert_not_equal(last_card,  @deck.cards.last)
  end

  def test_deal_to
    assert_equal(52, @deck.size)
    assert(@dale.hand.empty?, "#{@dale}'s hand is not empty!")
    assert(@kenny.hand.empty?, "#{@kenny}'s hand is not empty!")
    2.times do
      @deck.deal_to @dale
      @deck.deal_to @kenny
    end
    assert_equal(48, @deck.size)
  end

  def test_deck_empty
    # Deal out all the Cards first.
    @deck.size.times do
      @deck.deal_to(@dale)
    end

    assert_raise(DeckEmpty) do
      @deck.deal_to(@kenny)
    end
  end
end
