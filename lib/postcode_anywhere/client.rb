require 'faraday'
require 'faraday/multipart'
require 'json'
require 'timeout'
require 'postcode_anywhere/error'
require 'postcode_anywhere/response/raise_error'
require 'postcode_anywhere/response/parse_json'

module PostcodeAnywhere
  class Client
    attr_accessor(*Configuration::VALID_CONFIG_KEYS)

    def initialize(options = {})
      merged_options = PostcodeAnywhere.options.merge(options)

      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    # Perform an HTTP GET request
    def get(path, body_hash = {}, params = {})
      request(:get, path, params, body_hash)
    end

    # Perform an HTTP POST request
    def post(path, body_hash = {}, params = {})
      request(:post, path, params, body_hash)
    end

    def connection_options
      @connection_options ||= {
        builder: middleware,
        headers: {
          accept: "application/#{@format}",
          content_type: "application/#{@format}",
          user_agent: user_agent
        },
        request: {
          open_timeout: 10,
          timeout: 30
        }
      }
    end

    def connection
      @connection ||= Faraday.new(@endpoint, connection_options)
    end

    def middleware
      @middleware ||= Faraday::RackBuilder.new do |faraday|
        # Checks for files in the payload, otherwise leaves everything untouched
        faraday.request :multipart
        # Encodes as "application/x-www-form-urlencoded" if not already encoded
        faraday.request :url_encoded
        # Handle error responses
        faraday.response :postcode_anywhere_raise_error
        # Parse JSON response bodies
        faraday.response :postcode_anywhere_parse_json
        # Set default HTTP adapter
        faraday.adapter :net_http
      end
    end

    private

    def request(method, path, params = {}, body_hash = {})
      attach_api_key_to params
      connection.send(method.to_sym, path, params) do |request|
        request.body = compile_body(body_hash) unless body_hash.empty?
      end.env
      rescue Faraday::TimeoutError, Timeout::Error => error
        raise(PostcodeAnywhere::Error::RequestTimeout.new(error))
      rescue Faraday::ClientError, JSON::ParserError => error
        raise(PostcodeAnywhere::Error.new(error))
    end

    def attach_api_key_to(params)
      params.merge!('Key' => @api_key) unless params.keys.include? 'Key'
    end

    def compile_body(body_hash)
      body_hash.to_json
    end
  end
end
