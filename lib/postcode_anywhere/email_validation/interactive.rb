require 'postcode_anywhere/utils'
require 'postcode_anywhere/email_validation/validation_result'

module PostcodeAnywhere
  module EmailValidation
    module Interactive
      include ::PostcodeAnywhere::Utils

      API_VERSION = '1.10'

      VALIDATE_EMAIL_ENDPOINT =
        "/EmailValidation/Interactive/Validate/v#{API_VERSION}/json3.ws"

      def validate_email_address(email, timeout = 3, options = {})
        options.merge!('Email' => email, 'Timeout' => timeout)
        perform_with_object(
          :get,
          VALIDATE_EMAIL_ENDPOINT,
          options,
          PostcodeAnywhere::EmailValidation::ValidationResult
        )
      end
    end
  end
end
