require 'yaml'

module Vcloud
  module Tools
    module Tester
      class TestParameters
        def initialize(user_params, fixture_params)
          raise "No user parameters received" if user_params.empty?
          raise "No fixture parameters received" if fixture_params.empty?

          @user_params = user_params
          @fixture_params = fixture_params

          define_attr_readers
        end

        private

        def define_attr_readers
          test_params = @user_params.merge(@fixture_params)

          # Use +send+ because +define_method+ is private
          test_params.each_key do |param|
            self.class.send(:define_method, param) { test_params[param] }
          end
        end

        def method_missing (method_name)
          raise "Method TestParameters##{method_name} not defined"
        end
      end
    end
  end
end
