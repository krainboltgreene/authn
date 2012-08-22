require 'minitest/autorun'
require_relative '../../helper'

class TestAuthNSession < MiniTest::Unit::TestCase
  def setup
    AuthN.config.account_klass = Account

    Account.password "12341234"
    @controller = Controller
  end

  # def login(identifiers, password, klass = AuthN.config.account_klass)
  #   generate_session_and_instance_from klass.authenticate identifiers, password
  # end
  def test_that_login_returns_account_given_good_credentials
    actual = @controller.class_eval do
      login email: "kurtis@example.com", password: "12341234"
    end.class
    expected = Account
    assert_equal expected, actual
  end

  def test_that_login_returns_false_if_bad_password
    actual = @controller.class_eval do
      login email: "kurtis@example.com", password: "12341233"
    end
    expected = false
    assert_equal expected, actual
  end

  def test_that_login_returns_nil_if_no_account_found
    actual = @controller.class_eval do
      login email: "kurti@example.com", password: "12341234"
    end
    expected = false
    assert_equal expected, actual
  end
end
