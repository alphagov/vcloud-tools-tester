require 'yaml'

module Vcloud
  module Tools
    module Tester
      class TestParameters

        def initialize(config_file)
          load_config(config_file)
        end

        def load_config(config_file)
          unless File.exist?(config_file)
            raise ArgumentError.new("Missing required file: #{config_file}")
          end
          organization = ENV['FOG_CREDENTIAL']
          all_config = YAML::load(File.open(config_file))
          @input_config = all_config[organization]
        end

        def vdc_1_name
          @input_config["vdc_1_name"]
        end

        def vdc_2_name
          @input_config["vdc_2_name"]
        end

        def catalog
          @input_config["catalog"]
        end

        def vapp_template
          @input_config["vapp_template"]
        end

        def network1
          @input_config["network1"]
        end

        def network1_ip
          @input_config["network1_ip"]
        end

        def network2
          @input_config["network2"]
        end

        def network2_ip
          @input_config["network2_ip"]
        end

        def storage_profile
          @input_config["storage_profile"]
        end

        def default_storage_profile_name
          @input_config["default_storage_profile_name"]
        end

        def default_storage_profile_href
          @input_config["default_storage_profile_href"]
        end

        def vdc_1_storage_profile_href
          @input_config["vdc_1_storage_profile_href"]
        end

        def vdc_2_storage_profile_href
          @input_config["vdc_2_storage_profile_href"]
        end

      end
    end
  end
end
