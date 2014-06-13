# SimpleCov must run _first_ according to its README
if ENV['COVERAGE']
  require 'simplecov'

  # monkey-patch to prevent SimpleCov from reporting coverage percentage
  class SimpleCov::Formatter::HTMLFormatter
    def output_message(_message)
      nil
    end
  end

  SimpleCov.adapters.define 'gem' do
    add_filter '/spec/'
    add_filter '/features/'
    add_filter '/vendor/'

    add_group 'Libraries', '/lib/'
  end

  SimpleCov.minimum_coverage(80)
  SimpleCov.maximum_coverage_drop(20)
  SimpleCov.start 'gem'
end

require 'rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
