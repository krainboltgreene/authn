require 'helper'

class Account
  def id
    1
  end
end

class TestAuthNSession < MiniTestCase
  def setup
    @session = {}
    @object = AuthN::Session.new(@session, Account)
    @object.create(Account.new)
  end

  # def create(instance)
  #   session[key] = instance.send model_id_method
  # end
  def test_create
    # Given an instance it should create a new pair with the id as value
    expected = { :session_account_id => 1 }
    actual = @session
    assert_equal(expected, actual)
  end

  # def get
  #   session[key]
  # end
  def test_get
    # Returns the current session value, an id
    expected = 1
    actual = @object.get
    assert_equal(expected, actual)
  end

  # def destroy
  #   session.delete key
  # end
  def test_destroy
    @object.destroy
    expected = {}
    actual = @session
    assert_equal(expected, actual)
  end

  # def present?
  #   get.present?
  # end
  def test_present?
    # Should return true if the session pair exists
    expected = true
    actual = @object.present?
    assert_equal(expected, actual)

    # Should return false if the session pair doesn't exist
    @object.destroy
    expected = false
    actual = @object.present?
    assert_equal(expected, actual)
  end
end
