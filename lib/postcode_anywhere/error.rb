module PostcodeAnywhere
  # Custom error class for rescuing from all PostcodeAnywhere errors
  class Error < StandardError
    attr_reader :code
    attr_reader :cause
    attr_reader :resolution

    class << self
      def from_response(error_hash)
        message, code, cause, resolution = parse_error(error_hash)
        new(message, code, cause, resolution)
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

      def postcode_anywhere_errors
        @postcode_anywhere_errors ||= {
          -1 => PostcodeAnywhere::Error::UnknownError,
          2  => PostcodeAnywhere::Error::UnknownKey,
          3  => PostcodeAnywhere::Error::AccountOutOfCredit,
          4  => PostcodeAnywhere::Error::IpDenied,
          5  => PostcodeAnywhere::Error::UrlDenied,
          6  => PostcodeAnywhere::Error::ServiceDeniedForKey,
          7  => PostcodeAnywhere::Error::ServiceDeniedForPlan,
          8  => PostcodeAnywhere::Error::KeyDailyLimitExceeded,
          9  => PostcodeAnywhere::Error::SurgeProtectorRunning,
          10 => PostcodeAnywhere::Error::SurgeProtectorTriggered,
          11 => PostcodeAnywhere::Error::NoValidLicense,
          12 => PostcodeAnywhere::Error::ManagementKeyRequired,
          13 => PostcodeAnywhere::Error::DemoLimitExceeded,
          14 => PostcodeAnywhere::Error::FreeLimitExceeded,
          15 => PostcodeAnywhere::Error::IncorrectKeyType,
          16 => PostcodeAnywhere::Error::KeyExpired,
          17 => PostcodeAnywhere::Error::KeyDailyLimitExceeded
        }
      end

      private

      def parse_error(error_hash)
        if error_hash.nil?
          ['', nil, '', '']
        else
          [
            error_hash[:description],
            error_hash[:error],
            error_hash[:cause],
            error_hash[:resolution]
          ]
        end
      end

      def extract_message_from_error(body)
        m =
          /The exception message is \'(.+)?\'\. See server logs for more details./.match(body)
        return m.captures.first if m
      end
    end

    def initialize(description = '', code = nil, cause = '', resolution = '')
      super(description)
      @code = code
      @cause = cause
      @resolution = resolution
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

    # Postcode anywhere specific errors

    UnknownError = Class.new(ServerError)
    UnknownKey = Class.new(ClientError)
    AccountOutOfCredit = Class.new(Forbidden)
    IpDenied = Class.new(Forbidden)
    UrlDenied = Class.new(Forbidden)
    ServiceDeniedForKey = Class.new(Forbidden)
    ServiceDeniedForPlan = Class.new(Forbidden)
    KeyDailyLimitExceeded = Class.new(Forbidden)
    SurgeProtectorRunning = Class.new(Forbidden)
    SurgeProtectorTriggered = Class.new(Forbidden)
    NoValidLicense = Class.new(Forbidden)
    ManagementKeyRequired = Class.new(Forbidden)
    DemoLimitExceeded = Class.new(Forbidden)
    FreeLimitExceeded = Class.new(Forbidden)
    IncorrectKeyType = Class.new(Forbidden)
    KeyExpired = Class.new(Forbidden)
  end
end
