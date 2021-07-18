module Registration
  module Resource
    class Application
      include Router
      include Dependency

      dependency :registration_command, Command
      dependency :registration_query, Query

      def self.build
        instance = new
        instance.configure
        instance
      end

      def configure
        Command.configure(self)
        Query.configure(self)
      end

      route do |r|
        r.on do
          r.is do
            r.options do
              [204, { "Allow" => "OPTIONS, GET, POST" }, []]
            end

            r.post do
              handler = registration_command

              app = Rack::Builder.new do
                use(Command::ExposeHeaders)
                use(Rack::JSONBodyParser, "registration-key")
                use(Command::ValidateParameters, "registration-key")
                run(handler)
              end

              r.run(app)
            end
          end

          r.on String do |registration_id|
            r.is do
              r.get do
                handler = registration_query

                app = Rack::Builder.new do
                  run(handler)
                end

                r.run(app)
              end
            end
          end
        end
      end
    end
  end
end
