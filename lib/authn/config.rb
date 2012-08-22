module AuthN
  def self.config
    @config ||= Config.new
  end

  class Config < OpenStruct
    DEFAULTS = {
      :account_klass => :Account
    }

  end
end
