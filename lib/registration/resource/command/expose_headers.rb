module Registration
  module Resource
    class Command
      class ExposeHeaders
        def initialize(app)
          @app = app
        end

        def call(env)
          response = @app.(env)

          headers = response[1]
          headers["Access-Control-Expose-Headers"] = "location"

          response
        end
      end
    end
  end
end
