require 'postcode_anywhere/version'

module PostcodeAnywhere
  module Configuration
    VALID_CONNECTION_KEYS = [
      :endpoint,
      :api_key,
      :method,
      :user_agent
    ].freeze

    VALID_OPTIONS_KEYS      = [:format].freeze
    VALID_CONFIG_KEYS =
      VALID_CONNECTION_KEYS +
      VALID_OPTIONS_KEYS

    DEFAULT_METHOD      = :post
    DEFAULT_USER_AGENT  = "Postcode Anywhere Ruby Gem/#{PostcodeAnywhere::VERSION}"

    DEFAULT_API_KEY       = ''

    DEFAULT_FORMAT          = :json

    DEFAULT_ENDPOINT        = 'http://services.postcodeanywhere.co.uk/'

    attr_accessor(*VALID_CONFIG_KEYS)

    def self.extended(base)
      base.reset
    end

    def reset
      self.api_key          = DEFAULT_API_KEY
      self.endpoint         = DEFAULT_ENDPOINT
      self.format           = DEFAULT_FORMAT
      self.method           = DEFAULT_METHOD
      self.user_agent       = DEFAULT_USER_AGENT
    end

    def configure
      yield self
    end

    # Return the configuration values set in this module
    def options
      Hash[* VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten]
    end
  end
end
