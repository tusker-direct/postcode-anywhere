require 'faraday'
require 'json'

module PostcodeAnywhere
  module Response
    class ParseJson < Faraday::Middleware
      WHITESPACE_REGEX = /\A^\s*$\z/
      def parse(body)
        case body
        when WHITESPACE_REGEX, nil
          nil
        else
          convert_hash_keys JSON.parse(body)
        end
      end

      def to_snake_case(string)
        string.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
        gsub(/([a-z\d])([A-Z])/, '\1_\2').
        tr('-', '_').
        downcase
      end

      def underscore_key(k)
        to_snake_case(k.to_s).to_sym
      end

      def convert_hash_keys(value)
        case value
        when Array
          value.map { |v| convert_hash_keys(v) }
        when Hash
          Hash[value.map { |k, v| [underscore_key(k), convert_hash_keys(v)] }]
        else
          convert_boolean value
        end
      end

      def convert_boolean(value)
        return nil unless value
        return value unless value.class == String
        return true if (value.downcase == 'true')
        return false if (value.downcase == 'false')
        value
      end

      def on_complete(response)
        response.body =
          parse(response.body) if
            respond_to?(:parse) && !unparsable_status_codes.include?(response.status)
        raise_errors_in response.body
        response.body = breakout_items response.body
      end

      def breakout_items(response_body)
        if response_body.class == Hash && response_body.keys.include?(:items)
          return response_body[:items]
        end
        response_body
      end

      def raise_errors_in(response_body)
        (
          first_response = response_body
          if response_body.class == Array
            first_response = response_body.first
          end
          if first_response.class == Hash
            if first_response.keys.include? :error
              code = first_response[:error].to_i
              klass = error_klass_for code
              fail(klass.from_response(first_response))
            end
          end
        ) if response_body
      end

      def error_klass_for(code)
        klass = PostcodeAnywhere::Error.postcode_anywhere_errors[code]
        if !klass
          if code > 1000
            klass = PostcodeAnywhere::Error::ServiceSpecificError
          else
            PostcodeAnywhere::Error::UnknownError
          end
        end
        klass
      end

      def unparsable_status_codes
        [204, 301, 302, 304, 400]
      end
    end
  end
end

Faraday::Response.register_middleware(
  postcode_anywhere_parse_json: PostcodeAnywhere::Response::ParseJson
)
