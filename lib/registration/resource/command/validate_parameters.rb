module Registration
  module Resource
    class Command
      class ValidateParameters
        UUID_REGEXP = /^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i
        EMAIL_REGEXP = URI::MailTo::EMAIL_REGEXP

        def initialize(app, namespace)
          @app = app
          @namespace = namespace
        end

        def call(env)
          input = env[@namespace]
          errors = Hash.new { |hash, key| hash[key] = [] }

          registration_id = input.dig("registration_id")
          email_address = input.dig("email_address")

          if registration_id.nil?
            errors["registration_id"] << "Registration ID may not be blank."
          end

          unless registration_id.nil? || registration_id =~ UUID_REGEXP
            errors["registration_id"] << "Registration ID must be valid."
          end

          if email_address.nil?
            errors["email_address"] << "Email Address may not be blank."
          end

          unless email_address.nil? || email_address =~ EMAIL_REGEXP
            errors["email_address"] << "Email Address must be valid."
          end

          if !errors.empty?
            body = errors.to_json
            headers = { "Content-Type" => "application/json" }
            return Rack::Response.new(body, 400, headers).finish
          end

          @app.(env)
        end
      end
    end
  end
end
