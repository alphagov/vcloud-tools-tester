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

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
