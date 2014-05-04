require 'vcloud/tools/tester'

module Vcloud::Tools::Tester

  describe TestParameters do

    before(:all) do
      @data_dir = File.join(File.dirname(__FILE__), "/data")
    end

    context "loading config file" do

      it "loads input yaml when intialized" do
        ENV['FOG_CREDENTIAL'] = 'test-organisation'
        parameters = TestParameters.new("#{@data_dir}/test_config.yaml")
        test_vdc = parameters.vdc_1_name
        expect(test_vdc).to eq("test-vdc-name")
      end

      it "loads a different organization's yaml when env var changes" do
        ENV['FOG_CREDENTIAL'] = 'other-organisation'
        parameters = TestParameters.new("#{@data_dir}/test_config.yaml")
        test_vdc = parameters.vdc_1_name
        expect(test_vdc).to eq("other-vdc-name")
      end

      it "input yaml file can be changed" do
        ENV['FOG_CREDENTIAL'] = 'minimal-organisation'
        parameters = TestParameters.new("#{@data_dir}/test_minimal_config.yaml")
        test_vdc = parameters.vdc_1_name
        expect(test_vdc).to eq("minimal-vdc-name")
      end

    end

    context "parameters required for integration tests" do

      it "contains all the parameters required for the vCloud Launcher tests" do
        ENV['FOG_CREDENTIAL'] = "launcher-testing-organisation"
        parameters = TestParameters.new("#{@data_dir}/test_launcher_config.yaml")

        test_vdc_1_name = parameters.vdc_1_name
        expect(test_vdc_1_name).to eq("launcher-vdc-1-name")

        test_vdc_2_name = parameters.vdc_2_name
        expect(test_vdc_2_name).to eq("launcher-vdc-2-name")

        test_catalog = parameters.catalog
        expect(test_catalog).to eq("launcher-catalog")

        test_vapp_template = parameters.catalog_item
        expect(test_vapp_template).to eq("launcher-vapp-template")

        test_network_1 = parameters.network1
        expect(test_network_1).to eq("launcher-network-1")

        test_network_1_ip = parameters.network1_ip
        expect(test_network_1_ip).to eq("launcher-network-1-ip")

        test_network_2 = parameters.network2
        expect(test_network_2).to eq("launcher-network-2")

        test_network_2_ip = parameters.network2_ip
        expect(test_network_2_ip).to eq("launcher-network-2-ip")

        test_storage_profile = parameters.storage_profile
        expect(test_storage_profile).to eq("launcher-storage-profile")

        test_default_storage_profile_name = parameters.default_storage_profile_name
        expect(test_default_storage_profile_name).to eq("launcher-default-sp-name")

        test_default_storage_profile_href = parameters.default_storage_profile_href
        expect(test_default_storage_profile_href).to eq("launcher-default-sp-href")

        test_vdc_1_storage_profile_href = parameters.vdc_1_storage_profile_href
        expect(test_vdc_1_storage_profile_href).to eq("launcher-vdc-1-sp-href")

        test_vdc_2_storage_profile_href = parameters.vdc_2_storage_profile_href
        expect(test_vdc_2_storage_profile_href).to eq("launcher-vdc-2-sp-href")
      end

    end

    after(:each) do
      ENV.delete('FOG_CREDENTIAL')
    end

  end
end
