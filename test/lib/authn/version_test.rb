require 'minitest/autorun'
require_relative '../../helper'

class TestAuthNVersion < MiniTest::Unit::TestCase
  def setup
    # Setup logic here
  end

  def test_that_version_is_latest
    assert_equal "1.0.0", AuthN::VERSION
  end
end
