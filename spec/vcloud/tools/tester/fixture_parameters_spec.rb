require 'spec_helper'
require 'vcloud/tools/tester'

describe Vcloud::Tools::Tester::FixtureParameters do
  subject { Vcloud::Tools::Tester::FixtureParameters.new(user_params, expected_params) }

  before(:each) do
    stub_const("Fog::Compute::VcloudDirector::Network", Object)
    Vcloud::Core::Fog::ModelInterface.stub_chain(:new, :current_organization, :networks, :all).and_return(mock_found_interfaces)
    Vcloud::Core::Fog::ModelInterface.stub_chain(:new, :current_organization, :vdcs, :all).and_return(mock_found_vdcs)
  end

  let(:edge_gateway_name) { "Test edge gateway" }
  let(:vdc_1_name) { "Foo vDC" }
  let(:vdc_2_name) { "Bar vDC" }
  let(:network_1_name) { "Test network 1" }
  let(:network_2_name) { "Test network 2" }
  let(:network_1_id) { "12345678-1234-1234-1234-000000111111" }
  let(:network_2_id) { "12345678-1234-1234-1234-000000222222" }
  let(:network_1_href) { "https://example.com/admin/network/" + network_1_id }
  let(:network_2_href) { "https://example.com/admin/network/" + network_2_id }

  let(:user_params) do
    {
      "edge_gateway" =>  edge_gateway_name,
      "vdc_1_name"   =>  vdc_1_name,
      "vdc_2_name"   =>  vdc_2_name,
      "network_1"    =>  network_1_name,
      "network_2"    =>  network_2_name,
    }
  end

  let(:expected_params) do
    [
      "edge_gateway",
      "vdc_1_name",
      "vdc_2_name",
      "network_1",
      "network_2",
    ]
  end

  let(:mock_found_vdcs) do
    [
      mock_vdc_1,
      mock_vdc_2
    ]
  end

  let(:mock_vdc_1) do
      double(:vdc, :name => vdc_1_name, :available_networks => [ { :href => network_1_href } ])
  end

  let(:mock_vdc_2) do
      double(:vdc, :name => vdc_2_name, :available_networks => [ { :href => network_2_href } ])
  end

  let(:mock_found_interfaces) do
    [
      mock_fixture_network_1,
      mock_fixture_network_2,
    ]
  end

  let(:mock_fixture_network_1) do
    double(:network, :id => network_1_id, :name => network_1_name)
  end

  let(:mock_fixture_network_2) do
    double(:network, :id => network_2_id, :name => network_2_name)
  end

  let(:mock_fixture_uuids) { [ network_1_id, network_2_id ] }

  let(:network_config_1) do
    {
     :id => network_1_id,
     :href => "https://example.com/admin/network/" + network_1_id,
     :edge_gateway => edge_gateway_name,
     :name => network_1_name,
     :type => "application/vnd.vmware.vcloud.orgVdcNetwork+xml",
     :description => "",
     :is_inherited => "false",
     :is_shared => "true",
     :fence_mode => "natRouted",
     :gateway => "192.168.1.1",
     :netmask => "255.255.255.0",
     :dns1 => nil,
     :dns2 => nil,
     :dns_suffix => nil,
     :ip_ranges =>
     [
       {
         :start_address => "192.168.1.2",
         :end_address => "192.168.1.254"
       },
     ]
    }
  end

  let(:network_config_2) do
    {
     :id => network_2_id,
     :href => "https://example.com/admin/network/" + network_2_id,
     :edge_gateway => edge_gateway_name,
     :name => network_2_name,
     :type => "application/vnd.vmware.vcloud.orgVdcNetwork+xml",
     :description => "",
     :is_inherited => "false",
     :is_shared => "true",
     :fence_mode => "isolated",
     :gateway => "10.0.0.1",
     :netmask => "255.255.0.0",
     :dns1 => nil,
     :dns2 => nil,
     :dns_suffix => nil,
     :ip_ranges =>
     [
       {
         :start_address => "10.0.0.2",
         :end_address => "10.0.255.254"
       },
     ]
    }
  end

  context "correct fixture networks exist" do
    before(:each) do
      expect(mock_fixture_network_1).to receive(:instance_variable_get).with(:@attributes).and_return(network_config_1)
      expect(mock_fixture_network_2).to receive(:instance_variable_get).with(:@attributes).and_return(network_config_2)
    end

    it "doesn't provision new networks" do
      expect(Vcloud::Core::OrgVdcNetwork).not_to receive(:provision)
      subject
    end

    it "returns the correct fixture parameters" do
      expect(subject.fixture_params.values).to eq(mock_fixture_uuids)
    end
  end

  describe "correct fixture networks exist but aren't available to the appropriate vDCs" do
    let(:mock_found_vdcs) do
      [
        double(:vdc, :name => vdc_1_name, :available_networks => [ { :href => "https://example.com/admin/network/garbage" } ]),
        mock_vdc_2
      ]
    end

    it "raises an error" do
      expect(mock_fixture_network_1).to receive(:instance_variable_get).with(:@attributes).and_return(network_config_1)
      expect{ subject }.to raise_error(/already exists but is not configured as expected/)
    end
  end

  context "fixture networks don't yet exist" do
    let(:mock_found_interfaces) do
      [
        double(:network, :id => "55555555-1234-1234-1234-000000111111", :name => "rubbish"),
        double(:network, :id => "55555555-1234-1234-1234-000000222222", :name => "trash"),
      ]
    end

    it "tries to create them and returns the appropriate fixture parameters" do
      expect(Vcloud::Core::OrgVdcNetwork).to receive(:provision).and_return(mock_fixture_network_1)
      expect(Vcloud::Core::OrgVdcNetwork).to receive(:provision).and_return(mock_fixture_network_2)
      expect(subject.fixture_params.values).to eq(mock_fixture_uuids)
    end
  end

  context "when none of the network fixtures are needed" do

    let(:networkless_expected_params) {
      [
        "edge_gateway",
        "vdc_1_name",
        "vdc_2_name",
      ]
    }

    subject { Vcloud::Tools::Tester::FixtureParameters.new(user_params, networkless_expected_params) }

    it "returns an empty fixture_params hash" do
      expect(subject.fixture_params).to eq({})
    end

  end

end
