require 'spec_helper'
require 'vcloud/tools/tester'

describe Vcloud::Tools::Tester::UserParameters do
  subject(:parameters) do
    Vcloud::Tools::Tester::UserParameters.new(config_file, expected_params).user_params
  end

  before(:each) do
    stub_const('ENV', {'FOG_CREDENTIAL' => 'test-organisation'})
  end

  let(:data_dir) do
    File.join(File.dirname(__FILE__), "/data")
  end

  let(:config_file) do
    "#{data_dir}/test_config.yaml"
  end

  let(:expected_params) {[]}
  context "loading standard config file" do
    it "loads input yaml when intialized" do
      test_vdc = parameters["vdc_1_name"]
      expect(test_vdc).to eq("test-vdc-name")
    end

    it "loads a different organization's parameters when FOG_CREDENTIAL changes" do
      stub_const('ENV', {'FOG_CREDENTIAL' => 'other-organisation'})
      test_vdc = parameters["vdc_1_name"]
      expect(test_vdc).to eq("other-vdc-name")
    end

    it "gives a useful error when the FOG_CREDENTIAL is missing from the config" do
      stub_const('ENV', {'FOG_CREDENTIAL' => 'bogus-fog-credential'})
      expect { parameters }.to raise_error(RuntimeError, /No matching organisation was found in/)
    end
  end

  context "when an expected user-defined parameter is missing from the config file" do
    let(:expected_params) { [ "vdc_1_name", "bar" ] }

    it "raises an error if an expected user-defined parameter is not present" do
      expect{ parameters }.to raise_error(RuntimeError, "Required parameters not defined in #{config_file}: bar")
    end
  end

  context "loading minimal config file" do
    subject(:parameters) do
      Vcloud::Tools::Tester::UserParameters.new("#{data_dir}/test_minimal_config.yaml", expected_params).user_params
    end

    it "input yaml file can be changed" do
      stub_const('ENV', {'FOG_CREDENTIAL' => 'minimal-organisation'})
      test_vdc = parameters["vdc_1_name"]
      expect(test_vdc).to eq("minimal-vdc-name")
    end

    it "gives a useful error when FOG_CREDENTIAL is unset" do
      stub_const('ENV', {})
      expect { parameters }.to raise_error(RuntimeError, /Must set FOG_CREDENTIAL environment variable/)
    end
  end

  context "loading non-existent config file" do
    subject(:parameters) do
      Vcloud::Tools::Tester::UserParameters.new("#{data_dir}/nonexistent_config_file.yaml", expected_params).user_params
    end

    it "gives a useful error when there is no config file" do
      stub_const('ENV', {'FOG_CREDENTIAL' => 'minimal-organisation'})
      expect { parameters }.to raise_error(ArgumentError, /Missing required file/)
    end
  end
end
