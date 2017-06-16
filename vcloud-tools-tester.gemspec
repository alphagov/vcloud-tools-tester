# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vcloud/tools/tester/version'

Gem::Specification.new do |spec|
  spec.name          = "vcloud-tools-tester"
  spec.version       = Vcloud::Tools::Tester::VERSION
  spec.authors       = ["Anna Shipman"]
  spec.email         = ["anna.shipman@digital.cabinet-office.gov.uk"]
  spec.description   = %q{Tool to facilitate testing of vCloud Tools}
  spec.summary       = %q{vCloud Tools integration tests require secret parameters. This helps you manage them.}
  spec.homepage      = "https://github.com/gds-operations/vcloud-tools-tester"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency 'gem_publisher', '1.2.0'
  spec.add_development_dependency 'pry'

  spec.add_development_dependency 'rake', '>= 12'
  spec.add_development_dependency 'rspec', '>= 3.6'
  spec.add_development_dependency 'rubocop', '~> 0.49.1'
  spec.add_development_dependency 'simplecov', '~> 0.14.1'

  spec.add_runtime_dependency 'fog', '~> 1.36.0'
  spec.add_runtime_dependency 'vcloud-core'
  spec.add_runtime_dependency 'nokogiri', '~> 1.6.8.1'
end
