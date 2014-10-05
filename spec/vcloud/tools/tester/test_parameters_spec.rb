require 'spec_helper'
require 'vcloud/tools/tester'

describe Vcloud::Tools::Tester::TestParameters do
  before(:all) do
    @data_dir = File.join(File.dirname(__FILE__), "/data")
  end

  subject(:parameters) do
    Vcloud::Tools::Tester::TestParameters.new(user_params, fixture_params)
  end

  let(:config_file) { "#{@data_dir}/test_launcher_config.yaml" }
  let(:vdc_1_name) { "launcher-vdc-1-name" }
  let(:network_1_id) { "12345678-1234-1234-1234-000000111111" }
  let(:user_params) {
    {
      :vdc_1_name =>  vdc_1_name,
    }
  }
  let(:fixture_params) {
    {
      :network_1_id => network_1_id,
    }
  }

  context "parameters required for integration tests" do
    it "gives a useful error when the parameter is not set" do
      expect{parameters.doesnotexist}.to raise_error("Method TestParameters#doesnotexist not defined")
    end

    it "returns the correct value for the user-defined parameters" do
      test_vdc_1_name = parameters.vdc_1_name
      expect(test_vdc_1_name).to eq(vdc_1_name)
    end

    it "returns the correct value for the fixture parameters" do
      test_network_1_id = parameters.network_1_id
      expect(test_network_1_id).to eq(network_1_id)
    end
  end

  context "sanity checks" do
    context "no user-defined parameters passed in" do
      let(:user_params) {{}}
      it "raises an error if it receives no user-defined parameters" do
        expect{ parameters }.to raise_error("No user parameters received")
      end
    end

    context "no fixture parameters passed in" do
      let(:fixture_params) {{}}
      it "does not raise an error if it receives no fixture parameters" do
        expect{ parameters }.not_to raise_error
      end
    end
  end
end
