module Registration
  module Resource
    class Command
      class Session < ::MessageStore::Postgres::Session
        settings.each do |setting_name|
          setting setting_name
        end

        def self.build(settings: nil)
          registration_resource_settings = Settings.instance
          message_store_data = registration_resource_settings.data.dig("registration_resource", "message_store")

          message_store_settings = ::MessageStore::Postgres::Settings.build(message_store_data)

          super(settings: message_store_settings)
        end
      end
    end
  end
end
