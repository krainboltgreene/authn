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
      instance = find_instance_klass klass
      @current_user ||= instance.send :find, get_session(instance)
    end

    alias_method :current_account, :current_user

    def require_login
      session[:return_to_url] = request.url if AuthN.config.save_return_to_url && request.get?
      unauthenticated unless logged_in?
    end
    
    def redirect_back_or_to(url, flash_hash = {})
      redirect_to(session[:return_to_url] || url, :flash => flash_hash)
      session[:return_to_url] = nil
    end

    def find_instance_klass(klass)
      Object.const_get klass.capitalize
    end

    def klass_as_name(klass)
      klass.name.downcase
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
