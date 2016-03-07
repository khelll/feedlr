source 'https://rubygems.org'

gem 'jruby-openssl', platforms: :jruby
gem 'rake'
gem 'yard'

group :development do
  gem 'pry'
  gem 'pry-remote'
  gem 'pry-nav'
  platforms :ruby_19, :ruby_20, :ruby_21 do
    gem 'redcarpet'
  end
end

group :test do
  gem 'coveralls', '~> 0.7', require: false
  gem 'rspec', '>= 2.14'
  gem 'rspec-nc'
  gem 'rubocop', '>= 0.2', platforms: [:ruby_19, :ruby_20, :ruby_21]
  gem 'simplecov', '~> 0.7.1', require: false
  if RUBY_VERSION >= '1.9.3'
    gem 'guard', '~> 2.6'
    gem 'guard-rspec', '~> 4.2'
  end
  gem 'webmock', '~> 1.1'
  gem 'vcr', '~> 2.5'
end

# Specify your gem's dependencies in feedlr.gemspec
gemspec
