module Registration
  module Resource
    class Query
      class Session < ::ViewData::Postgres::Session
        settings.each do |setting_name|
          setting setting_name
        end

        def self.build(settings: nil)
          registration_resource_settings = Settings.instance
          view_data_data = registration_resource_settings.data.dig("registration_resource", "view_data")

          view_data_settings = ::ViewData::Postgres::Settings.build(view_data_data)

          super(settings: view_data_settings)
        end
      end
    end
  end
end
