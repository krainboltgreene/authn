module AuthN
  def self.config
    @config ||= Config.new Config.defaults
  end

  class Config < AltStruct
    @@defaults = {
      password_digest_method: :password_digest,
      account_klass: "Account",
      login_password_key: :password,
      model_id_method: :id,
      model_critera_method: :where,
      session_key_function: ->(klass) { :"session_#{klass}_id" },
      save_return_to_url: true
    }

    def self.defaults
      @@defaults
    end
  end
end
