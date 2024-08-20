# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'postcode_anywhere/version'

Gem::Specification.new do |spec|
  spec.name          = "postcode-anywhere"
  spec.version       = PostcodeAnywhere::VERSION
  spec.authors       = ["Edward Woodcock"]
  spec.email         = ["edward@simple-merchant.com"]
  spec.summary       = %q{Full set of Postcode Anywhere API clients - http://postcodeanywhere.co.uk}
  spec.description   = %q{A number of fully-tested clients for interacting with all of the available postcode anywhere services, including capture, cleansing, payment validation and email validation}
  spec.homepage      = "https://github.com/simplemerchant/postcode-anywhere"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'faraday', '>= 0.9.0'
  spec.add_runtime_dependency 'memoizable', '>= 0.4.2'
end
