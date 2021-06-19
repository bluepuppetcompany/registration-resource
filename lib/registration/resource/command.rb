module Registration
  module Resource
    class Command
      include Dependency

      dependency :register, Register

      def self.configure(receiver, attr_name: nil)
        attr_name ||= :registration_command
        instance = build
        receiver.public_send("#{attr_name}=", instance)
      end

      def self.build
        instance = new
        instance.configure
        instance
      end

      def configure
        Register.configure(self)
      end

      def call(env)
        input = env["registration-key"]

        registration_id = input["registration_id"]
        email_address = input["email_address"]

        register.(registration_id: registration_id, email_address: email_address)

        request = Rack::Request.new(env)

        location = "#{request.url}#{registration_id}"

        headers = {
          "Location" => location
        }

        [202, headers, []]
      end
    end
  end
end
