module AuthN
  module Session
    def self.included(object)
      object.extend ClassMethods
    end

    module ClassMethods
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
        @current_user ||= get_session klass_as_name klass
      end

      alias_method :current_account, :current_user

      private

      def find_instance_klass(klass)
        const_get klass.capitalize
      end

      def klass_as_name(klass)
        klass.name.downcase
      end

      def generate_session_and_instance_from(instance)
        instance.tap { instance_and_session instance if instance }
      end

      def instance_and_session(instance)
        instance.tap { |instance| create_session instance.class, instance }
      end

      def create_session(klass, instance)
        session[:"session_#{klass_as_name(klass)}_id"] = instance.id
      end

      def destroy_session(klass)
        session.delete :"session_#{klass_as_name(klass)}_id"
      end

      def check_session(klass)
        get_session(klass).present?
      end

      def get_session(klass)
        session[:"session_#{klass_as_name(klass)}_id"]
      end
    end
  end
end
