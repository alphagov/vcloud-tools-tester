require 'yaml'

module Vcloud
  module Tools
    module Tester
      class TestSetup
        attr_reader :test_params

        def initialize(config_file, expected_user_params)
          user_params = Vcloud::Tools::Tester::UserParameters.new(config_file, expected_user_params).user_params
          fixture_params = Vcloud::Tools::Tester::FixtureParameters.new(user_params, expected_user_params).fixture_params

          @test_params = Vcloud::Tools::Tester::TestParameters.new(user_params, fixture_params)
        end
      end
    end
  end
end
