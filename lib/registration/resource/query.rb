module Registration
  module Resource
    class Query
      include Dependency

      dependency :get_registration, Get

      def self.configure(receiver, attr_name: nil)
        attr_name ||= :registration_query
        instance = build
        receiver.public_send("#{attr_name}=", instance)
      end

      def self.build
        instance = new
        instance.configure
        instance
      end

      def configure
        Get.configure(self)
      end

      def call(env)
        script_name = env["SCRIPT_NAME"]
        registration_id = script_name[1..-1]

        registration = get_registration.(registration_id)

        if registration.nil?
          return error_response
        end

        unless registration.is_email_rejected || registration.is_registered
          return error_response
        end

        headers = {
          "Content-Type" => "application/json"
        }

        body = {
          "is_email_rejected" => registration.is_email_rejected,
          "is_registered" => registration.is_registered
        }.to_json

        [200, headers, [body]]
      end

      def error_response
        headers = { "Content-Type" => "application/json" }
        body = { "error" => "Registration is not available." }.to_json
        Rack::Response.new(body, 404, headers).finish
      end
    end
  end
end
