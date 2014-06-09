require 'yaml'

module Vcloud
  module Tools
    module Tester
      class TestParameters
        def initialize(config_file)
          @config_file = config_file
          load_config(@config_file)
        end

        def load_config(config_file)
          unless File.exist?(config_file)
            raise ArgumentError.new("Missing required file: #{config_file}")
          end

          organization = ENV.fetch('FOG_CREDENTIAL') do
            raise "Must set FOG_CREDENTIAL envvar"
          end

          all_config = YAML::load_file(config_file)

          @input_config = all_config.fetch(organization) do
            raise "Invalid FOG_CREDENTIAL value '#{organization}'"
          end

          @input_config.each_key do |param|
            self.class.send(:define_method, param) { @input_config[param] }
          end
        end

        def method_missing (method_name)
          raise "Method TestParameters##{method_name} not defined. Perhaps you need to add this parameter to '#{@config_file}'."
        end
      end
    end
  end
end
