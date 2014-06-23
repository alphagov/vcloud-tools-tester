require 'yaml'

module Vcloud
  module Tools
    module Tester
      class UserParameters
        attr_reader :user_params

        def initialize(config_file, expected_user_params)
          @config_file = config_file
          @expected_user_params = expected_user_params || []

          parse_config
        end

        private

        def parse_config
          unless File.exist?(@config_file)
            raise ArgumentError.new("Missing required file: #{@config_file}")
          end

          organization = ENV.fetch('FOG_CREDENTIAL') do
            raise "Must set FOG_CREDENTIAL environment variable"
          end

          all_config = YAML::load_file(@config_file)

          @user_params = all_config.fetch(organization) do
            raise "Invalid FOG_CREDENTIAL environment variable value '#{organization}'"
          end

          defined_keys = @user_params.keys
          missing_params = @expected_user_params - defined_keys
          if missing_params.any?
            raise "Required parameters not defined in #{@config_file}: " + missing_params.join(", ")
          end
        end
      end
    end
  end
end
