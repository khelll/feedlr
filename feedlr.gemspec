# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'feedlr/version'

Gem::Specification.new do |gem|
  gem.add_dependency 'hashie', '~> 3.0'
  gem.add_dependency 'multi_xml', '~> 0.5'
  gem.add_dependency 'multi_json', '~> 1.0'
  gem.add_dependency 'faraday', '~> 0.9'
  gem.add_dependency 'faraday_middleware', '~> 0.9'

  gem.name          = 'feedlr'
  gem.version       = Feedlr::Version
  gem.authors       = ['Khaled alHabache']
  gem.email         = ['khellls@gmail.com']
  gem.description   = %q(A Ruby interface to the Feedly API.)
  gem.summary       = %q(A Ruby interface to the Feedly API.)
  gem.homepage      = 'http://github.com/khelll/feedlr'
  gem.license       = 'LGPL-3'
  gem.required_ruby_version = '>= 1.9.2'
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files = Dir.glob('spec/**/*')
  gem.require_paths = ['lib']
end
