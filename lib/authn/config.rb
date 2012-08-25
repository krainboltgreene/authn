module AuthN
  def self.config
    @config ||= Config.new Config::DEFAULTS
  end

  class Config
    include AltStruct::M
    DEFAULTS = {
      account_klass: :Account,
      password_digest_name: :password_digest,
      login_password_name: :password,
      model_id_name: :id,
      model_critera_name: :where
    }

  end
end
