# require 'minitest/autorun'
# require 'helper'

# class TestAuthNModel < MiniTest::Unit::TestCase
#   def setup
#     Account.stubs(:where).returns([Account.new(email: "kurtis@example.com", password: "12341234")])
#     @account = Account.new
#     BCrypt::Password.stubs(:new)
#   end

#   def teardown
#     AuthN.instance_variable_set(:@config, nil)
#   end

#   # def config=(options)
#   #   @@config = options
#   # end
#   #
#   # def config
#   #   @@config ||= AuthN::Config.new
#   # end
#   def test_model_has_class_wide_config_settings
#     expected = AuthN::Config
#     actual = Account.config.class
#     assert_equal expected, actual
#   end

#   # def has_authentication(options = {})
#   #   merge_config_with options
#   # end
#   def test_model_gets_has_authentication_method
#     assert Account.public_methods.include? :has_authentication
#   end

#   def test_has_authentication_config_combinds_with_default_config
#     expected = "Account"
#     actual = Account.config.account_klass
#     assert_equal expected, actual
#   end

#   def test_has_authentication_config_merges_into_model_config
#     expected = "User"
#     actual = Account.tap { |a| a.has_authentication account_klass: "User" }.config.account_klass
#     assert_equal expected, actual
#   end

#   # def authenticate(identifiers = {})
#   #   password = identifiers.delete AuthN.config.login_password_key
#   #   criteria = send AuthN.config.model_critera_method, identifiers
#   #   instance = criteria.first
#   #   if instance && password
#   #     instance.authenticate(password) ? instance : false
#   #   end
#   # end
#   def test_authenticate_returns_instance_if_given_good_credentials
#     assert Account.authenticate(email: "kurtis@example.com", password: "12341234").is_a? Account
#   end

#   # def test_authenticate_returns_false_if_bad_password
#   #   actual =
#   #   expected =
#   #   assert_equal expected, actual
#   # end

#   # def test_authenticate_return_nil_if_no_record_found
#   #   actual =
#   #   expected =
#   #   assert_equal expected, actual
#   # end
# end
