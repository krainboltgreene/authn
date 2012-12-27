require 'minitest/autorun'
require 'helper'

class TestAuthNSession < MiniTest::Unit::TestCase
  def setup
    Account.password "12341234"
    @controller = Controller.new
    @controller.session = {}
    @controller.request = Request.new(url:'http://example.com', method: 'get')
  end

  # def login(identifiers, password, klass = AuthN.config.account_klass)
  #   generate_session_and_instance_from klass.authenticate identifiers, password
  # end
  def test_that_login_returns_account_given_good_credentials
    instance = @controller.instance_eval { login email: "kurtis@example.com", password: "12341234" }
    actual = instance.class
    expected = Account
    assert_equal expected, actual
  end

  def test_that_login_returns_false_if_bad_password
    actual = @controller.instance_eval { login email: "kurtis@example.com", password: "12341233" }
    expected = false
    assert_equal expected, actual
  end

  def test_that_login_returns_nil_if_no_account_found
    actual = @controller.instance_eval { login email: "kurti@example.com", password: "12341234" }
    expected = nil
    assert_equal expected, actual
  end

  def test_that_login_sets_session
    @controller.instance_eval { login email: "kurtis@example.com", password: "12341234" }
    assert @controller.session[:session_account_id]
  end

  def test_that_login_stores_session_account_id
    instance = @controller.instance_eval { login email: "kurtis@example.com", password: "12341234" }
    actual = @controller.session[:session_account_id]
    expected = instance.id
    assert_equal expected, actual
  end

  # def auto_login(instance)
  #   instance_and_session instance
  # end
  def test_that_auto_login_returns_instance
    instance = @controller.instance_eval { auto_login Account.new }
    actual = instance.class
    expected = Account
    assert_equal expected, actual
  end

  def test_that_auto_login_sets_session
    @controller.instance_eval { auto_login Account.new }
    assert @controller.session.has_key? :session_account_id
  end

  def test_that_auto_login_stores_session_account_id
    instance = @controller.instance_eval { auto_login Account.new }
    actual = @controller.session[:session_account_id]
    expected = instance.id
    assert_equal expected, actual
  end

  # def logged_in?(instance = nil, klass = AuthN.config.account_klass)
  #   klass = instance.class if instance
  #   klass = const_get(klass) unless instance
  #   check_session klass
  # end

  def test_that_logged_in_returns_true_if_logged_in
    @controller.instance_eval { login email: "kurtis@example.com", password: "12341234" }
    actual = @controller.instance_eval { logged_in? }
    expected = true
    assert_equal expected, actual
  end

  def test_that_logged_in_returns_false_if_not_logged_in
    @controller.session
    actual = @controller.instance_eval { logged_in? }
    expected = false
    assert_equal expected, actual
  end

  # def logout(instance = nil, klass = AuthN.config.account_klass)
  #   klass = instance.class if instance
  #   klass = const_get(klass) unless instance
  #   destroy_session klass
  # end

  def test_that_logout_empties_the_session
    @controller.instance_eval { login email: "kurtis@example.com", password: "12341234" }
    @controller.instance_eval { logout }
    refute @controller.session.has_key? :session_account_id
  end
  
  # def require_login
  #   session[:return_to_url] = request.url if AuthN.config.save_return_to_url && request.get?
  #   unauthenticated unless logged_in?
  # end
  
  def test_that_require_login_sets_the_return_to_url
    @controller.instance_eval { require_login }
    actual = @controller.session[:return_to_url]
    expected = @controller.request.url
    assert_equal expected, actual
  end
end
