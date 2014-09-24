require 'postcode_anywhere/model_base'

module PostcodeAnywhere
  module BankAccountValidation
    class ValidationResult < PostcodeAnywhere::ModelBase
      # Indicates whether the account number a sortcode are valid.
      # Example: false
      attr_reader :is_correct

      # Indicates whether the account can accept direct debits.
      # Certain accounts (e.g. savings) will not accept direct debits.
      # Example: false
      attr_reader :is_direct_debit_capable

      # More detail about the outcome of the validation process.
      # Describes reasons validation failed or changes made to pass validation.
      # DetailsChanged indicates that the account and sortcode should be changed for
      # BACs submission (check CorrectedAccountNumber and CorrectedSortCode).
      # CautiousOK is set where the sortcode exists but no validation rules are
      # set for the bank (very rare).
      #
      # Values:
      #   - None
      #   - UnknownSortCode
      #   - InvalidAccountNumber
      #   - OK
      #   - CautiousOK
      #   - DetailsChanged
      attr_reader :status_information

      # The correct version of the SortCode. This will be 6 digits long with no hyphens.
      # It may differ from the original sortcode.
      attr_reader :corrected_sort_code

      # The correct version of the AccountNumber.
      # This will be 8 digits long and in the form expected for BACs submission.
      attr_reader :corrected_account_number

      # The correctly formatted IBAN for the account.
      attr_reader :iban

      # The name of the banking institution.
      attr_reader :bank

      # The banking institution's BIC, also know as the SWIFT BIC.
      attr_reader :bank_bic

      # The name of the account holding branch.
      attr_reader :branch

      # The branch's BIC.
      attr_reader :branch_bic

      # Line 1 of the branch's contact address. NB: This is the address to be used for BACs
      # enquiries and may be a contact centre rather than the branch's address.
      attr_reader :contact_address_line1

      # Line 2 of the branch's contact address.
      attr_reader :contact_address_line2

      # The branch's contact post town.
      attr_reader :contact_post_town

      # The branch's contact postcode.
      attr_reader :contact_postcode

      # The branch's contact phone number.
      attr_reader :contact_phone

      # The branch's contact fax number.
      attr_reader :contact_fax

      # Indicates that the account supports the faster payments service.
      attr_reader :faster_payments_supported

      # Indicates that the account supports the CHAPS service.
      attr_reader :chaps_supported
    end
  end
end
