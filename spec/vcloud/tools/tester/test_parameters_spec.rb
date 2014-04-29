require 'vcloud/tools/tester'

module Vcloud::Tools::Tester
  describe TestParameters do

    context "launcher parameters" do

      before(:all) do
        @data_dir = File.join(File.dirname(__FILE__), "/data")
      end

      it "loads input yaml when intialized" do
        parameters = TestParameters.new("#{@data_dir}/test_launcher_config.yaml")
        test_vdc = parameters.vdc_name
        expect(test_vdc).to eq("test-vdc-name")
      end

      it "input yaml can be changed" do
        parameters = TestParameters.new("#{@data_dir}/test_minimal_config.yaml")
        test_vdc = parameters.vdc_name
        expect(test_vdc).to eq("minimal-vdc-name")
      end

    end

  end
end
