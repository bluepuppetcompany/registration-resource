module Registration
  module Resource
    class Command
      class Register
        include Dependency
        include Messaging::StreamName

        dependency :session, Session
        dependency :write, Messaging::Postgres::Write
        dependency :clock, Clock::UTC
        dependency :identifier, Identifier::UUID::Random

        def self.configure(receiver, attr_name: nil)
          attr_name ||= :register
          instance = build
          receiver.public_send("#{attr_name}=", instance)
        end

        def self.build
          instance = new
          instance.configure
          instance
        end

        def configure
          Session.configure(self)
          Messaging::Postgres::Write.configure(self, session: session)
          Clock::UTC.configure(self)
          Identifier::UUID::Random.configure(self)
        end

        def call(registration_id:, email_address:)
          claim_id = identifier.get
          user_id = identifier.get
          time = clock.iso8601

          register = Registration::Client::Messages::Commands::Register.new
          register.registration_id = registration_id
          register.claim_id = claim_id
          register.user_id = user_id
          register.email_address = email_address
          register.time = time

          stream_name = command_stream_name(registration_id, "registration")

          write.(register, stream_name)
        end
      end
    end
  end
end
