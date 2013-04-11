require "helper"

class TestAuthNSessions < MiniTest::Unit::TestCase
  def setup
    BCrypt::Password.stubs(:new)
    Account.stubs(:where).returns([Account.new(id: rand, email: "kurtis@example.com", password: "12341234")])
    @controller = Controller.new
    @controller.session = {}
  end

  def inside_controller(&block)
    @controller.instance_eval &block
  end

  # def login(identifiers, password, klass = AuthN.config.account_klass)
  #   generate_session_and_instance_from klass.authenticate identifiers, password
  # end
  def test_that_login_returns_account_given_good_credentials
    instance = inside_controller { login email: "kurtis@example.com", password: "12341234" }
    actual = instance.class
    expected = Account
    assert_equal expected, actual
  end

  def test_that_login_returns_false_if_bad_password
    actual = inside_controller { login email: "kurtis@example.com", password: "12341233" }
    expected = false
    assert_equal expected, actual
  end

  def test_that_login_returns_nil_if_no_account_found
    actual = inside_controller { login email: "kurti@example.com", password: "12341234" }
    expected = nil
    assert_equal expected, actual
  end

  def test_that_login_sets_session
    inside_controller { login email: "kurtis@example.com", password: "12341234" }
    assert @controller.session[:session_account_id]
  end

  def test_that_login_stores_session_account_id
    instance = inside_controller { login email: "kurtis@example.com", password: "12341234" }
    actual = @controller.session[:session_account_id]
    expected = instance.id
    assert_equal expected, actual
  end

  # def auto_login(instance)
  #   instance_and_session instance
  # end
  def test_that_auto_login_returns_instance
    instance = inside_controller { auto_login Account.new }
    actual = instance.class
    expected = Account
    assert_equal expected, actual
  end

  def test_that_auto_login_sets_session
    @controller.instance_eval { auto_login Account.new }
    assert @controller.session.has_key? :session_account_id
  end

  def test_that_auto_login_stores_session_account_id
    instance = inside_controller { auto_login Account.new }
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
    actual = inside_controller do
      login email: "kurtis@example.com", password: "12341234"
      logged_in?
    end
    expected = true
    assert_equal expected, actual
  end

  def test_that_logged_in_returns_false_if_not_logged_in
    @controller.session
    actual = inside_controller { logged_in? }
    expected = false
    assert_equal expected, actual
  end

  # def logout(instance = nil, klass = AuthN.config.account_klass)
  #   klass = instance.class if instance
  #   klass = const_get(klass) unless instance
  #   destroy_session klass
  # end
  def test_that_logout_empties_the_session
    inside_controller do
      login email: "kurtis@example.com", password: "12341234"
      logout
    end
    refute @controller.session.has_key? :session_account_id
  end
end
