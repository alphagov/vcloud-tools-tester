require 'spec_helper'
require 'vcloud/tools/tester'

describe Vcloud::Tools::Tester::UserParameters do
  before(:all) do
    @data_dir = File.join(File.dirname(__FILE__), "/data")
  end

  context "loading config file" do

    it "loads input yaml when intialized" do
      stub_const('ENV', {'FOG_CREDENTIAL' => 'test-organisation'})
      parameters = TestParameters.new("#{@data_dir}/test_config.yaml")
      test_vdc = parameters.vdc_1_name
      expect(test_vdc).to eq("test-vdc-name")
    end

    it "loads a different organization's yaml when env var changes" do
      stub_const('ENV', {'FOG_CREDENTIAL' => 'other-organisation'})
      parameters = TestParameters.new("#{@data_dir}/test_config.yaml")
      test_vdc = parameters.vdc_1_name
      expect(test_vdc).to eq("other-vdc-name")
    end

    it "input yaml file can be changed" do
      stub_const('ENV', {'FOG_CREDENTIAL' => 'minimal-organisation'})
      parameters = TestParameters.new("#{@data_dir}/test_minimal_config.yaml")
      test_vdc = parameters.vdc_1_name
      expect(test_vdc).to eq("minimal-vdc-name")
    end

    it "gives a useful error when FOG_CREDENTIAL is unset" do
      stub_const('ENV', {})
      expect {
        TestParameters.new("#{@data_dir}/test_minimal_config.yaml")
      }.to raise_error(RuntimeError, /Must set FOG_CREDENTIAL envvar/)
    end

    it "gives a useful error when the FOG_CREDENTIAL is missing from the config" do
      stub_const('ENV', {'FOG_CREDENTIAL' => 'bogus-fog-credential'})
      expect {
        TestParameters.new("#{@data_dir}/test_config.yaml")
      }.to raise_error(RuntimeError, /Invalid FOG_CREDENTIAL value/)
    end

    it "gives a useful error when there is no config file" do
      stub_const('ENV', {'FOG_CREDENTIAL' => 'minimal-organisation'})
      expect {
        TestParameters.new("#{@data_dir}/non_existent_testing_config.yaml")
      }.to raise_error(ArgumentError, /Missing required file/)
    end
  end
end
