require 'minitest/autorun'
require_relative '../../helper'

class TestAuthNSession < MiniTest::Unit::TestCase
  def setup
    AuthN.config.account_klass = :Account
    Account.password "12341234"
    Controller.instance_variable_set :@session, {}
  end

  # def login(identifiers, password, klass = AuthN.config.account_klass)
  #   generate_session_and_instance_from klass.authenticate identifiers, password
  # end
  def test_that_login_returns_account_given_good_credentials
    instance = Controller.login email: "kurtis@example.com", password: "12341234"
    actual = instance.class
    expected = Account
    assert_equal expected, actual
  end

  def test_that_login_returns_false_if_bad_password
    actual = Controller.login email: "kurtis@example.com", password: "12341233"
    expected = false
    assert_equal expected, actual
  end

  def test_that_login_returns_nil_if_no_account_found
    actual = Controller.login email: "kurti@example.com", password: "12341234"
    expected = nil
    assert_equal expected, actual
  end

  def test_that_login_sets_session
    Controller.login email: "kurtis@example.com", password: "12341234"
    assert Controller.session[:session_account_id]
  end

  def test_that_login_stores_session_account_id
    instance = Controller.login email: "kurtis@example.com", password: "12341234"
    actual = Controller.session[:session_account_id]
    expected = instance.id
    assert_equal expected, actual
  end

  # def auto_login(instance)
  #   instance_and_session instance
  # end
  def test_that_auto_login_returns_instance
    instance = Controller.auto_login Account.new
    actual = instance.class
    expected = Account
    assert_equal expected, actual
  end

  def test_that_auto_login_sets_session
    Controller.auto_login Account.new
    assert Controller.session.has_key? :session_account_id
  end

  def test_that_auto_login_stores_session_account_id
    instance = Controller.auto_login Account.new
    actual = Controller.session[:session_account_id]
    expected = instance.id
    assert_equal expected, actual
  end

  # def logged_in?(instance = nil, klass = AuthN.config.account_klass)
  #   klass = instance.class if instance
  #   klass = const_get(klass) unless instance
  #   check_session klass
  # end

  def test_that_logged_in_returns_true_if_logged_in
    Controller.login email: "kurtis@example.com", password: "12341234"
    actual = Controller.logged_in?
    expected = true
    assert_equal expected, actual
  end

  def test_that_logged_in_returns_false_if_not_logged_in
    Controller.session
    actual = Controller.logged_in?
    expected = false
    assert_equal expected, actual
  end

  # def logout(instance = nil, klass = AuthN.config.account_klass)
  #   klass = instance.class if instance
  #   klass = const_get(klass) unless instance
  #   destroy_session klass
  # end

  def test_that_logout_empties_the_session
    Controller.login email: "kurtis@example.com", password: "12341234"
    Controller.logout
    refute Controller.session.has_key? :session_account_id
  end
end
