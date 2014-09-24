require 'postcode_anywhere/utils'
require 'postcode_anywhere/cleanse_plus/cleansed_address'

module PostcodeAnywhere
  module CleansePlus
    module Interactive
      include ::PostcodeAnywhere::Utils

      API_VERSION = '1.00'

      CLEANSE_ADDRESS_ENDPOINT = "CleansePlus/Interactive/Cleanse/v#{API_VERSION}/json.ws"

      def cleanse_address(address, options = {})
        address
        perform_with_object(
          :get,
          CLEANSE_ADDRESS_ENDPOINT,
          options,
          PostcodeAnywhere::CleansePlus::CleansedAddress
        )
      end
    end
  end
end
