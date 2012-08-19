module AuthN
  module Model

    def authenticate_using(provided_password)
      password_digest == BCrypt::Password.new(provided_password)
    end
    private :authenticate_using

    def self.included(object)
      object.extend ClassMethods
    end

    module ClassMethods
      def self.has_authentication(o = {})
        options = o.empty? ? AuthN::DEFAULTS.merge(o) : AuthN::DEFAULTS
        define_authenticate_method
      end

      # Return instance if account was found and password matched
      # Return false if account was found and password didn't match
      # Return nil if account wasn't found OR password wasn't given
      def self.authenticate(identifers = {}, password)
        criteria = where identifiers
        instance = critera.first
        if account && password
          instance.authenticate password ? account : false
        end
      end
    end
  end
end
