module AuthN
  module Sessions
    private

    def login(identifiers, klass = AuthN.config.account_klass)
      generate_session_and_instance find_instance_klass(klass).authenticate identifiers
    end

    def auto_login(instance)
      generate_session_and_instance instance
    end

    def logged_in?(instance = nil, klass = AuthN.config.account_klass)
      klass = instance.class if instance
      klass = find_instance_klass klass unless instance
      Session.new(session, klass).present?
    end

    def logout(instance = nil, klass = AuthN.config.account_klass)
      klass = instance.class if instance
      klass = find_instance_klass klass unless instance
      Session.new(session, klass).destroy
    end

    def current_user(klass = AuthN.config.account_klass)
      @current_user ||= get_session klass_as_name find_instance_klass klass
    end

    alias_method :current_account, :current_user

    def require_login
      unauthenticated unless logged_in?
    end

    def find_instance_klass(klass)
      Object.const_get klass.capitalize
    end

    def generate_session_and_instance(instance)
      instance.tap { |i| Session.new(session, i.class).create(i) } if instance
    end
  end
end
