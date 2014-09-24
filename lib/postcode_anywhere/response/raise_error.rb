require 'faraday'
require 'postcode_anywhere/error'

module PostcodeAnywhere
  module Response
    class RaiseError < Faraday::Response::Middleware
      def on_complete(response)
        status_code = response.status.to_i
        klass = PostcodeAnywhere::Error.errors[status_code]
        return unless klass
        fail(klass.from_response(response))
      end
    end
  end
end

Faraday::Response.register_middleware(
  postcode_anywhere_raise_error: PostcodeAnywhere::Response::RaiseError
)
