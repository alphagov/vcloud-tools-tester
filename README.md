# vCloud Tools Tester

The integration tests for [vCloud Tools](https://github.com/gds-operations/vcloud-tools) require a lot of parameters that are specific to your environment, and not ones you want to make public. 

vCloud tools Tester makes it easy to run the vCloud Tools integration tests using a config file.

## Installation

Add this line to your application's Gemfile:

    gem 'vcloud-tools-tester'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vcloud-tools-tester

## Testing

Run the default suite of tests (e.g. lint, unit, features):

    bundle exec rake

There are no integration tests for this project.

## Contributing

Please see [CONTRIBUTING.md].
