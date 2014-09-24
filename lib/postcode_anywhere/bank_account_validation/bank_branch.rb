require 'postcode_anywhere/model_base'

module PostcodeAnywhere
  module BankAccountValidation
    class BankBranch < PostcodeAnywhere::ModelBase
      # The name of the banking institution.
      attr_reader :bank

      # The banking institution's BIC, also know as the SWIFT BIC.
      attr_reader :bank_bic

      # The name of the account holding branch.
      attr_reader :branch

      # The branch's BIC.
      attr_reader :branch_bic

      # Line 1 of the branch's contact address.
      # NB: This is the address to be used for BACs enquiries and may be a
      # contact centre rather than the branch's address.
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
