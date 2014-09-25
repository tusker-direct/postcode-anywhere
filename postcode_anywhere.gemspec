# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'postcode_anywhere/version'

Gem::Specification.new do |spec|
  spec.name          = "postcode_anywhere"
  spec.version       = PostcodeAnywhere::VERSION
  spec.authors       = ["Edward Woodcock"]
  spec.email         = ["edward@simple-merchant.com"]
  spec.summary       = %q{Client gem for Postcode Anywhere API - http://postcodeanywhere.co.uk}
  spec.description   = %q{This gem provides a number of clients for interacting with the API}
  spec.homepage      = "https://github.com/simplemerchant/postcode_anywhere"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday'
  spec.add_dependency 'memoizable'

  spec.add_development_dependency 'pre-commit'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'spring-commands-rspec'
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
end
