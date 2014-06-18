require 'spec_helper'
require 'vcloud/tools/tester'

describe Vcloud::Tools::Tester::TestParameters do
  before(:all) do
    @data_dir = File.join(File.dirname(__FILE__), "/data")
  end

  context "parameters required for integration tests" do

    let(:config_file) { "#{@data_dir}/test_launcher_config.yaml" }
    let(:parameters) do
      ENV['FOG_CREDENTIAL'] = "launcher-testing-organisation"
      TestParameters.new(config_file)
    end

    it "gives a useful error when the parameter is not set" do
      expect{parameters.doesnotexist}.to raise_error("Method TestParameters#doesnotexist not defined. Perhaps you need to add this parameter to '#{config_file}'.")
    end

    it "contains all the parameters required for the vCloud Launcher tests" do
      test_vdc_1_name = parameters.vdc_1_name
      expect(test_vdc_1_name).to eq("launcher-vdc-1-name")

      test_vdc_2_name = parameters.vdc_2_name
      expect(test_vdc_2_name).to eq("launcher-vdc-2-name")

      test_catalog = parameters.catalog
      expect(test_catalog).to eq("launcher-catalog")

      test_vapp_template = parameters.vapp_template
      expect(test_vapp_template).to eq("launcher-vapp-template")

      test_network_1 = parameters.network_1
      expect(test_network_1).to eq("launcher-network-1")

      test_network_1_ip = parameters.network_1_ip
      expect(test_network_1_ip).to eq("launcher-network-1-ip")

      test_network_2 = parameters.network_2
      expect(test_network_2).to eq("launcher-network-2")

      test_network_2_ip = parameters.network_2_ip
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
end
