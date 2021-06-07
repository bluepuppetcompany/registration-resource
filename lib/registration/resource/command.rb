module Registration
  module Resource
    class Command
      def self.configure(receiver, attr_name: nil)
        attr_name ||= :registration_command
        instance = build
        receiver.public_send("#{attr_name}=", instance)
      end

      def self.build
        instance = new
        instance
      end

      def call(env)
        input = env["registration-key"]

        registration_id = input["registration_id"]
        email_address = input["email_address"]

        # TODO: Database I/O.

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
