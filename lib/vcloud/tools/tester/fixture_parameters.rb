module Vcloud
  module Tools
    module Tester
      class FixtureParameters
        attr_reader :fixture_params

        def initialize(user_params)
          @vcloud_api = Vcloud::Fog::ModelInterface.new
          @user_params = user_params
          ensure_vcloud_fixtures
          extract_fixture_params
        end

        private

        def ensure_vcloud_fixtures
          generate_fixtures_config
          correct_networks = ensure_networks_correct(@expected_fixtures_config[:networks])
          @fixtures = correct_networks
        end

        def generate_fixtures_config
          @expected_fixtures_config = {
            :networks => {
              :network_1 => {
                :edge_gateway => @user_params["edge_gateway"],
                :vdc_name     => @user_params["vdc_1_name"],
                :name         => @user_params["network_1"],
                :type         => 'application/vnd.vmware.vcloud.orgVdcNetwork+xml',
                :description  => '',
                :is_inherited => 'false',
                :is_shared    => 'true',
                :fence_mode   => 'natRouted',
                :gateway      => '192.168.1.1',
                :netmask      => '255.255.255.0',
                :dns1         => nil,
                :dns2         => nil,
                :dns_suffix   => nil,
                :ip_ranges    => [
                  {
                    :start_address  => "192.168.1.2",
                    :end_address    => "192.168.1.254"
                  }
                ],
              },
              :network_2 => {
                :edge_gateway => @user_params["edge_gateway"],
                :vdc_name     => @user_params["vdc_2_name"],
                :name         => @user_params["network_2"],
                :type         => 'application/vnd.vmware.vcloud.orgVdcNetwork+xml',
                :description  => '',
                :is_inherited => 'false',
                :is_shared    => 'true',
                :fence_mode   => 'isolated',
                :gateway      => '10.0.0.1',
                :netmask      => '255.255.0.0',
                :dns1         => nil,
                :dns2         => nil,
                :dns_suffix   => nil,
                :ip_ranges    => [
                  {
                    :start_address  => "10.0.0.2",
                    :end_address    => "10.0.255.254"
                  }
                ],
              },
            },
          }
        end

        def ensure_networks_correct(expected_network_config)
          existing_networks = @vcloud_api.current_organization.networks.all(false)

          correct_networks = []

          expected_network_config.each_value do |expected_config|
            # find an existing network matching the expected configuration
            found_network = existing_networks.detect { |n| n.name == expected_config[:name] }

            unless found_network
              new_network = Vcloud::Core::OrgVdcNetwork.provision(expected_config)
              correct_networks << new_network
              next
            end

            unless network_matches_expected?(found_network, expected_config)
              raise "Network '#{expected_config[:name]}' already exists but is not configured as expected.
                You should delete this network before re-running the tests; it will be re-created by the tests."
            end

            correct_networks << found_network
          end

          correct_networks
        end

        def extract_fixture_params
          raise "No fixtures present" if @fixtures.empty?

          @fixture_params = {}

          @fixtures.each do |fixture|
            case fixture
            when ::Fog::Compute::VcloudDirector::Network, Vcloud::Core::OrgVdcNetwork
              @expected_fixtures_config[:networks].each do |network_ref, expected_network_config|
                if expected_network_config[:name] == fixture.name
                  @fixture_params["#{network_ref}_id"] = fixture.id
                end
              end
            end
          end
        end

        def network_matches_expected?(found_network, expected_network_config)
            network_config_matches_expected?(found_network, expected_network_config) &&
              network_available_to_correct_vdc?(found_network, expected_network_config)
        end

        def network_config_matches_expected?(found_network, expected_network_config)
            found_network_config = found_network.instance_variable_get(:@attributes)

            expected_network_config = expected_network_config.reject do |key|
              %w{edge_gateway vdc_name}.include?(key.to_s)
            end

            found_network_config = found_network_config.reject do |key|
              %w{id edge_gateway href}.include?(key.to_s)
            end

            # sort hashes ready for comparison
            found_network_config = Hash[found_network_config.sort]
            expected_network_config = Hash[expected_network_config.sort]

            found_network_config == expected_network_config
        end

        def network_available_to_correct_vdc?(found_network, expected_network_config)
          vdcs = @vcloud_api.current_organization.vdcs.all(false)

          vdcs.each do |vdc|
            next unless vdc.name == expected_network_config[:vdc_name]

            matching_network = vdc.available_networks.detect { |n| n[:href].split('/').last == found_network.id }

            return true if matching_network
          end

          false
        end
      end
    end
  end
end
