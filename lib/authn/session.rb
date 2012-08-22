module AuthN
  module Session
    def self.included(object)
      object.extend ClassMethods
    end

    module ClassMethods
      def login(identifiers, klass = AuthN.config.account_klass)
        generate_session_and_instance_from const_get(klass).authenticate identifiers
      end

      def auto_login(instance)
        instance_and_session instance
      end

      def logged_in?(instance = nil, klass = AuthN.config.account_klass)
        klass = instance.class if instance
        klass = const_get(klass) unless instance
        check_session klass
      end

      def logout(instance = nil, klass = AuthN.config.account_klass)
        klass = instance.class if instance
        klass = const_get(klass) unless instance
        destroy_session klass
      end

      private

      def generate_session_and_instance_from(instance)
        instance.tap { instance_and_session instance if instance }
      end

      def instance_and_session(instance)
        instance.tap { |instance| create_session instance.class, instance }
      end

      def create_session(klass, instance)
        session[:"session_#{klass}_id"] = instance.id
      end

      def destroy_session(klass)
        session.delete :"session_#{klass}_id"
      end

      def check_session(klass)
        session[:"session_#{klass}_id"].present?
      end
    end
  end
end
