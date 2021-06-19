module Registration
  module Resource
    class Settings < ::Settings
      def self.instance
        @instance ||= build
      end

      def self.data_source
        Default.data_source
      end

      def self.names
        [
          :registration_resource
        ]
      end

      module Default
        def self.data_source
          ENV["REGISTRATION_RESOURCE_SETTINGS_PATH"] || "settings/registration_resource.json"
        end
      end
    end
  end
end
