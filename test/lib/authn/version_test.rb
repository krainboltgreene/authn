require 'minitest/autorun'
require_relative '../../helper'

class TestAuthNVersion < MiniTest::Unit::TestCase
  def test_that_version_is_latest
    assert_equal "2.5.0", AuthN::VERSION
  end
end
