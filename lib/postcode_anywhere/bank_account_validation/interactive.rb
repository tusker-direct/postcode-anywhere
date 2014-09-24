require 'postcode_anywhere/utils'
require 'postcode_anywhere/bank_account_validation/bank_branch'

module PostcodeAnywhere
  module BankAccountValidation
    module Interactive
      include ::PostcodeAnywhere::Utils

      API_VERSION = '1.00'

      RETRIEVE_BY_SORTCODE_ENDPOINT =
        "BankAccountValidation/Interactive/RetrieveBySortcode/v#{API_VERSION}/json.ws"

      def retrieve_by_sortcode(sort_code, options = {})
        options.merge!('SortCode' => sort_code)
        perform_with_object(
          :get,
          RETRIEVE_BY_SORTCODE_ENDPOINT,
          options,
          PostcodeAnywhere::BankAccountValidation::BankBranch
        )
      end
    end
  end
end
