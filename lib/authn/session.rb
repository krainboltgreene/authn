module AuthN
  module Session
    def self.included(object)
      object.extend ClassMethods
    end

    module ClassMethods
      def login(identifiers, klass = AuthN.config.account_klass)
        generate_session_and_instance_from klass.authenticate identifiers
      end

      def auto_login(instance)
        instance_and_session instance
      end

      def logged_in?(instance = nil, klass = AuthN.config.account_klass)
        klass = instance.class if instance
        check_session klass
      end

      def logout(instance = nil, klass = AuthN.config.account_klass)
        klass = instance.class if instance
        destroy_session klass
      end

      private

      def generate_session_and_instance_from(instance)
         if instance then instance_and_session instance else false end
      end

      def instance_and_session(instance)
        instance.tap { |instance| create_session instance.class, instance }
      end

      def create_session(klass, instance)
        session[:"session_#{klass}_id"] = instance.id
      end

      def destroy_session(klass)
        session[:"session_#{klass}_id"] = nil
      end

      def check_session(klass)
        session[:"session_#{klass}_id"].present?
      end
    end
  end
end
