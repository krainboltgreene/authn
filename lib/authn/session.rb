module AuthN
  class Session
    attr_accessor :session, :klass

    def initialize(session, klass)
      self.session = session
      self.klass = klass
    end

    def create(instance)
      session[key] = instance.send model_id_method
    end

    def get
      session[key]
    end

    def destroy
      session.delete key
    end

    def present?
      get.present?
    end

    private

    def key
      AuthN.config.session_key_function.call klass_name
    end

    def klass_name
      klass.name.downcase
    end

    def model_id_method
      AuthN.config.model_id_method
    end
  end
end
