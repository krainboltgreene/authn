module AuthN
  def self.config
    @config ||= Config.new
  end

  class Config < OpenStruct
    DEFAULTS = { }

  end
end
