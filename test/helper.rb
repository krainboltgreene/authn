require 'authn'
require "minitest/autorun"
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
  has_secure_password
  attr_accessor :password_digest

  def self.password(password=nil)
    if password
      @password = password
    else
      @password
    end
  end

  def self.where(hash)
    account = if hash[:email] == "kurtis@example.com"
      Account.new(password: password, password_confirmation: password)
    end
    [account]
  end

  def id
    @id ||= rand(100000)
  end
end


class Controller
  include AuthN::Sessions
  attr_accessor :session
end
