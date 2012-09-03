module AuthN
  def self.config
    @config ||= Config.new Config::DEFAULTS
  end

  class Config < AltStruct
    DEFAULTS = {
      account_klass: :Account,
      password_digest_method: :password_digest,
      login_password_key: :password,
      model_id_method: :id,
      model_critera_method: :where,
      session_key_function: ->(klass) { :"session_#{klass}_id" }
    }
  end
end
