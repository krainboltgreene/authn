module AuthN
  module Session
    private

    def login(identifiers, klass = AuthN.config.account_klass)
      generate_session_and_instance_from find_instance_klass(klass).authenticate identifiers
    end

    def auto_login(instance)
      instance_and_session instance
    end

    def logged_in?(instance = nil, klass = AuthN.config.account_klass)
      klass = instance.class if instance
      klass = find_instance_klass klass unless instance
      check_session klass
    end

    def logout(instance = nil, klass = AuthN.config.account_klass)
      klass = instance.class if instance
      klass = find_instance_klass klass unless instance
      destroy_session klass
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

    def klass_as_name(klass)
      (klass.respond_to?(:name) ? klass.name : klass).downcase
    end

    def generate_session_and_instance_from(instance)
      instance.tap { |i| instance_and_session i if i }
    end

    def instance_and_session(instance)
      instance.tap { |i| create_session i.class, i }
    end

    def create_session(klass, instance)
      key = AuthN.config.session_key_function.call klass_as_name klass
      session[key] = instance.send AuthN.config.model_id_method
    end

    def destroy_session(klass)
      key = AuthN.config.session_key_function.call klass_as_name klass
      session.delete key
    end

    def check_session(klass)
      get_session(klass).present?
    end

    def get_session(klass)
      key = AuthN.config.session_key_function.call klass_as_name klass
      session[key]
    end
  end
end
