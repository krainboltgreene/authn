require 'minitest/autorun'
require_relative '../../helper'

class TestAuthNConfig < MiniTest::Unit::TestCase
  def setup

  end

  # def self.config
  #   @config ||= Config.new
  # end
  def test_config_returns_config_object
    actual = AuthN.config.class
    expected = AuthN::Config
    assert_equal expected, actual
  end
end
