require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'simplecov'
SimpleCov.start

require 'coveralls'
Coveralls.wear!

require 'pry'
require 'MX/Banxico'


SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new [
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
]


RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
end
