require 'vcloud/tools/tester'

module Vcloud::Tools::Tester
  describe TestParameters do

    context "it returns launcher parameters" do

      it "loads input yaml" do
        parameters = TestParameters.new
        @data_dir = File.join(File.dirname(__FILE__), "/data")
        test_config = parameters.load_config("#{@data_dir}/test_config.yaml")
        expect(test_config.class).to eq(Hash)
      end

    end

  end
end
