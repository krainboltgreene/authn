require 'minitest/autorun'
require 'helper'

class TestAuthN < MiniTest::Unit::TestCase
  def test_that_things_work
    assert true
  end

  def test_that_AuthN_is_defined
    assert(defined?(AuthN))
  end
end
