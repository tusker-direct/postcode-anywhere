require 'postcode_anywhere/client'
require 'postcode_anywhere/email_validation/interactive'

module PostcodeAnywhere
  module EmailValidation
    class Client < ::PostcodeAnywhere::Client
      include PostcodeAnywhere::EmailValidation::Interactive
      def initialize(options = {})
        super(options)
      end
    end
  end
end
