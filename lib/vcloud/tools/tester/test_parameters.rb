require 'yaml'

module Vcloud
  module Tools
    module Tester
      class TestParameters

        def initialize(config_file)
          load_config(config_file)
        end

        def load_config(config_file)
          organization = ENV['FOG_CREDENTIAL']
          all_config = YAML::load(File.open(config_file))
          @input_config = all_config[organization]
        end

        def vdc_name
          @input_config["vdc_name"]
        end

        def catalog
          @input_config["catalog"]
        end

        def catalog_item
          @input_config["catalog_item"]
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

      end
    end
  end
end
