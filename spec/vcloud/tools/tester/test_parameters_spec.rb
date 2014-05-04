require 'vcloud/tools/tester'

module Vcloud::Tools::Tester

  describe TestParameters do

    before(:all) do
      @data_dir = File.join(File.dirname(__FILE__), "/data")
    end

    context "launcher parameters" do

      it "loads input yaml when intialized" do
        ENV['FOG_CREDENTIAL'] = 'test-organisation'
        parameters = TestParameters.new("#{@data_dir}/test_launcher_config.yaml")
        test_vdc = parameters.vdc_name
        expect(test_vdc).to eq("test-vdc-name")
      end

      it "loads a different organization's yaml when env var changes" do
        ENV['FOG_CREDENTIAL'] = 'other-organisation'
        parameters = TestParameters.new("#{@data_dir}/test_launcher_config.yaml")
        test_vdc = parameters.vdc_name
        expect(test_vdc).to eq("other-vdc-name")
      end

      it "input yaml file can be changed" do
        ENV['FOG_CREDENTIAL'] = 'minimal-organisation'
        parameters = TestParameters.new("#{@data_dir}/test_minimal_config.yaml")
        test_vdc = parameters.vdc_name
        expect(test_vdc).to eq("minimal-vdc-name")
      end

    end

    after(:each) do
      ENV.delete('FOG_CREDENTIAL')
    end

  end
end
