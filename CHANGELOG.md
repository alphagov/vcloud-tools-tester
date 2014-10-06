## 0.3.0 (2014-10-06)

Features:

  - Fixture creation (specifically networks at present) is now optional, based on
    whether the 'network_1' or 'network_2' keys are required. Prevents unneccessary
    pre-requisites for integration tests that do not require these fixtures, and should
    be automatically enabled.

## 0.2.0 (2014-08-11)

API changes:

  - Now depends on vCloud Core v0.9, using an API to access fog instead of accessing fog directly.

## 0.1.3 (2014-07-15)

Bugfixes:

  - Fixes issue where we were not receiving parameters correctly in cases
    where networks did not already exist.

## 0.1.2 (2014-07-14)

Make dependency on vCloud Core less restrictive; allow any version in the 0.x series.

## 0.1.1 (2014-07-14)

Update dependency on vCloud Core to version 0.6.0.

## 0.1.0 (2014-06-23)

Features:

  - Test parameters should now be accessed by calling:

    ```ruby
    test_params = Vcloud::Tools::Tester::TestSetup.new(config_file, expected_user_params).test_params
    ```
  - Vcloud::Tools::Tester::TestSetup now creates network fixtures if not already
    present in the environment and sets the network ID parameters by quering the API.
  - Now possible to specify which user-defined parameters should be defined in the
    YAML-formatted configuration file; passed as an array to TestSetup#initialize.

## 0.0.6 (2014-05-28)

Features:

  - Add edge_gateway_id parameter

## 0.0.5 (2014-05-23)

Features:

  - Add network_1_id and network_2_id parameters

## 0.0.4 (2014-05-20)

Features:

  - Add edge_gateway parameter
  - Add provider_network, provider_network_id, provider_network_ip parameters

## 0.0.3 (2014-05-09)

Bugfixes:

  - Makes input parameter names consistent, e.g. `network_1_ip` rather than `network1_ip`.

## 0.0.2 (2014-05-09)

Features:

  - Raise a useful error if config file is missing

## 0.0.1 (2014-05-06)

  - First release of gem
