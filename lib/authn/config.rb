module AuthN
  def self.config
    @config ||= Config.new Config::DEFAULTS
  end

  class Config
    include AltStruct::M
    DEFAULTS = {
      account_klass: :Account,
      password_digest_method: :password_digest,
      login_password_key: :password,
      model_id_method: :id,
      model_critera_method: :where,
    }

  end
end
