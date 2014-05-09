require 'rspec/core/rake_task'

task :default => [:rubocop, :spec]

RSpec::Core::RakeTask.new(:spec) do |task|
  task.pattern = FileList['spec/vcloud/**/*_spec.rb']
end

require 'gem_publisher'
task :publish_gem do
  gem = GemPublisher.publish_if_updated("vcloud-tools-tester.gemspec", :rubygems)
  puts "Published #{gem}" if gem
end

require 'rubocop/rake_task'

Rubocop::RakeTask.new(:rubocop) do |task|
  task.options = ['--lint']
end
