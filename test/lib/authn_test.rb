require 'helper'

class TestAuthN < MiniTestCase
  def test_that_namespace_defined
    assert(defined?(AuthN))
  end
end
