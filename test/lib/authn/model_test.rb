require 'minitest/autorun'
require 'helper'

class TestAuthNModel < MiniTest::Unit::TestCase
  def setup
    @account = Account.new
  end

  # def has_authentication(options = {})
  #   merge_config_with options
  # end
  def test_model_gets_has_authentication_method
    assert Account.public_methods.include? :has_authentication
  end

  def test_has_authentication_config_combinds_with_default_config
    actual =
    expected =
    assert_equal expected, actual
  end

  def test_has_autehntication_config_merges_in_model_config
    actual =
    expected =
    assert_equal expected, actual
  end

  # def config=(options)
  #   @@config = options
  # end
  #
  # def config
  #   @@config ||= AuthN::Config.new
  # end
  def test_model_has_class_wide_config_settings
    actual =
    expected =
    assert_equal expected, actual
  end

  # def authenticate(identifiers = {})
  #   password = identifiers.delete AuthN.config.login_password_key
  #   criteria = send AuthN.config.model_critera_method, identifiers
  #   instance = criteria.first
  #   if instance && password
  #     instance.authenticate(password) ? instance : false
  #   end
  # end
  def test_authenticate_returns_instance_if_given_good_credentials
    actual =
    expected =
    assert_equal expected, actual
  end

  def test_authenticate_returns_false_if_bad_password
    actual =
    expected =
    assert_equal expected, actual
  end

  def test_authenticate_return_nil_if_no_record_found
    actual =
    expected =
    assert_equal expected, actual
  end
end
