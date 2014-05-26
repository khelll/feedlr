require 'simplecov'
require 'coveralls'


SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter]

SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage(99.15)
end

require_relative '../lib/feedlr.rb'

require 'pry'
require 'feedlr'
require 'rspec'
require 'webmock/rspec'
require 'vcr'
require 'cgi'
require 'multi_json'



VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
  #   c.default_cassette_options = { :record => :none }
end

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def access_token
  '_oauth_access_token'
end
