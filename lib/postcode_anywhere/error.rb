module PostcodeAnywhere
  # Custom error class for rescuing from all Twitter errors
  class Error < StandardError
    class << self
      def from_response(response)
        message = parse_error(response.body)
        new(message)
      end

      def errors
        @errors ||= {
          400 => PostcodeAnywhere::Error::BadRequest,
          401 => PostcodeAnywhere::Error::Unauthorized,
          403 => PostcodeAnywhere::Error::Forbidden,
          404 => PostcodeAnywhere::Error::NotFound,
          406 => PostcodeAnywhere::Error::NotAcceptable,
          408 => PostcodeAnywhere::Error::RequestTimeout,
          422 => PostcodeAnywhere::Error::UnprocessableEntity,
          429 => PostcodeAnywhere::Error::TooManyRequests,
          500 => PostcodeAnywhere::Error::InternalServerError,
          502 => PostcodeAnywhere::Error::BadGateway,
          503 => PostcodeAnywhere::Error::ServiceUnavailable,
          504 => PostcodeAnywhere::Error::GatewayTimeout
        }
      end

      private

      def parse_error(body)
        if body.nil? || (message = extract_message_from_error(body)).nil?
          ''
        else
          message
        end
      end

      def extract_message_from_error(body)
        m =
          /The exception message is \'(.+)?\'\. See server logs for more details./.match(body)
        return m.captures.first if m
      end
    end

    def initialize(message = '')
      super(message)
    end

    ClientError = Class.new(self)
    BadRequest = Class.new(ClientError)
    Unauthorized = Class.new(ClientError)
    Forbidden = Class.new(ClientError)
    NotFound = Class.new(ClientError)
    NotAcceptable = Class.new(ClientError)
    RequestTimeout = Class.new(ClientError)
    UnprocessableEntity = Class.new(ClientError)
    TooManyRequests = Class.new(ClientError)
    ServerError = Class.new(self)
    InternalServerError = Class.new(ServerError)
    BadGateway = Class.new(ServerError)
    ServiceUnavailable = Class.new(ServerError)
    GatewayTimeout = Class.new(ServerError)
  end
end
