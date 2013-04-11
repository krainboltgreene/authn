require "coveralls"
Coveralls.wear! do
  add_filter "/test/"
end
require "minitest/autorun"
require "mocha/setup"
require "pry"
require "authn"

class MiniTestCase < MiniTest::Unit::TestCase

end

module ActiveModel::Model
  def self.included(base)
    base.class_eval do
      extend  ActiveModel::Naming
      extend  ActiveModel::Translation
      include ActiveModel::Validations
      include ActiveModel::Conversion
      include ActiveModel::SecurePassword
    end
  end

  def initialize(params={})
    params.each do |attr, value|
      self.public_send("#{attr}=", value)
    end if params
  end

  def persisted?
    false
  end
end

class Account
  include ActiveModel::Model
  include AuthN::Model

  has_authentication
  has_secure_password

  attr_accessor :id, :email, :password, :password_digest
end
