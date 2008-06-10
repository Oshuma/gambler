require File.dirname(__FILE__) + '/../helper'

# Tests Gambler::Client
class TestClient < Test::Unit::TestCase
  def setup
    @client = Client.new
  end

  def test_new_client
    assert_kind_of(Client, @client)
  end
end
