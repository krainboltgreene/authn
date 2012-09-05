require 'minitest/autorun'
require_relative '../../helper'

class TestAuthNVersion < MiniTest::Unit::TestCase
  def test_that_version_is_latest
    assert_equal "3.0.1", AuthN::VERSION
  end
end
