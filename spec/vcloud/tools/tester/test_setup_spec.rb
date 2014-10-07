require 'spec_helper'
require 'vcloud/tools/tester'

describe Vcloud::Tools::Tester::TestSetup do
  before(:each) do
    Vcloud::Tools::Tester::UserParameters.stub(:new).and_return(mock_user_parameters)
    Vcloud::Tools::Tester::FixtureParameters.stub(:new).and_return(mock_fixture_parameters)
    Vcloud::Tools::Tester::TestParameters.stub(:new).and_return(mock_test_parameters)
  end

  let(:example_filename) { "example_filename.yaml" }
  let(:expected_params) { [] }

  let(:mock_user_parameters) do
    double(:user_parameters, :user_params => {})
  end

  let(:mock_fixture_parameters) do
    double(:fixture_parameters, :fixture_params => {})
  end

  let(:mock_test_parameters) do
    double(:test_parameters, :test_params => {})
  end

  subject do
    Vcloud::Tools::Tester::TestSetup.new(example_filename, expected_params)
  end

  it "responds with test parameters" do
    expect(subject).to respond_to(:test_params)
  end

  it "calls the appropriate methods" do
    expect(Vcloud::Tools::Tester::UserParameters).to receive(:new).with(example_filename, expected_params)
    expect(Vcloud::Tools::Tester::FixtureParameters).to receive(:new).with({}, expected_params)
    expect(Vcloud::Tools::Tester::TestParameters).to receive(:new).with({}, {})

    subject.test_params
  end
end
