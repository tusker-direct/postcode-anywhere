require 'postcode_anywhere/client'
require 'postcode_anywhere/bank_account_validation/interactive'

module PostcodeAnywhere
  module BankAccountValidation
    class Client < ::PostcodeAnywhere::Client
      include PostcodeAnywhere::BankAccountValidation::Interactive
      def initialize(options = {})
        super(options)
      end
    end
  end
end
