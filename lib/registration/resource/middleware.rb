module Registration
  module Resource
    class Middleware
      def initialize(app)
        @app = app
        @application = Application.build
      end

      def call(env)
        response = @application.(env)

        if response.nil?
          return @app.(env)
        end

        response
      end
    end
  end
end
