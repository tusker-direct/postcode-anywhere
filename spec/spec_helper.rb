require 'bundler/setup'
Bundler.setup

require 'postcode_anywhere'

require 'webmock/rspec'

WebMock.disable_net_connect!()

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def stub_get(path)
  stub_request(:get, PostcodeAnywhere.endpoint + path)
end

def stub_post(path)
  stub_request(:post, PostcodeAnywhere.endpoint + path)
end

def a_post(path)
  a_request(:post, PostcodeAnywhere.endpoint + path)
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
