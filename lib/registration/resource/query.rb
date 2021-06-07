module Registration
  module Resource
    class Query
      def self.configure(receiver, attr_name: nil)
        attr_name ||= :registration_query
        instance = build
        receiver.public_send("#{attr_name}=", instance)
      end

      def self.build
        instance = new
        instance
      end

      def call(env)
        script_name = env["SCRIPT_NAME"]
        registration_id = script_name[1..-1]

        # TODO: Database I/O.

        headers = {
          "Content-Type" => "application/json"
        }

        body = {
          "is_email_rejected": false,
          "is_registered": true
        }.to_json

        [200, headers, [body]]
      end
    end
  end
end
