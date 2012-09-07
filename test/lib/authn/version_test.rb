require 'minitest/autorun'
require 'helper'

class TestAuthNVersion < MiniTest::Unit::TestCase
  def test_that_version_is_latest
    assert_equal "3.1.4", AuthN::VERSION
  end
end
