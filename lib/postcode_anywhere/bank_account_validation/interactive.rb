require 'postcode_anywhere/utils'
require 'postcode_anywhere/bank_account_validation/bank_branch'
require 'postcode_anywhere/bank_account_validation/validation_result'

module PostcodeAnywhere
  module BankAccountValidation
    module Interactive
      include ::PostcodeAnywhere::Utils

      API_VERSION = '1.00'

      RETRIEVE_BY_SORTCODE_ENDPOINT =
        "BankAccountValidation/Interactive/RetrieveBySortcode/v#{API_VERSION}/json.ws"

      VALIDATE_ACCOUNT_ENDPOINT =
        "BankAccountValidation/Interactive/Validate/v#{API_VERSION}/json.ws"

      def retrieve_by_sortcode(sort_code, options = {})
        options.merge!('SortCode' => sort_code)
        perform_with_object(
          :get,
          RETRIEVE_BY_SORTCODE_ENDPOINT,
          options,
          PostcodeAnywhere::BankAccountValidation::BankBranch
        )
      end

      def validate_account(account_number, sort_code, options = {})
        options.merge!('SortCode' => sort_code, 'AccountNumber' => account_number)
        perform_with_object(
          :get,
          VALIDATE_ACCOUNT_ENDPOINT,
          options,
          PostcodeAnywhere::BankAccountValidation::ValidationResult
        )
      end
    end
  end
end
