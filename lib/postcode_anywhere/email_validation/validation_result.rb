require 'postcode_anywhere/model_base'

module PostcodeAnywhere
  module EmailValidation
    class ValidationResult < PostcodeAnywhere::ModelBase
      # The address the email was sent to.
      # Example: info@google.com
      attr_reader :email

      # The mail server that was used to perform the server and account validation steps on.
      # Not populated if the DNS record was not found.
      # Example: google.com.s9a1.psmtp.com
      attr_reader :mail_server

      # Indicates that the format of the email appears valid.
      # Example: true
      attr_reader :valid_format

      # Indicates that a valid DNS record was found for the email.
      # Example: true
      attr_reader :found_dns_record
    end
  end
end
