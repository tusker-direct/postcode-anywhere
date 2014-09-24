require 'postcode_anywhere/utils'
require 'postcode_anywhere/cleanse_plus/cleansed_address'

module PostcodeAnywhere
  module CleansePlus
    module Interactive
      include ::PostcodeAnywhere::Utils

      API_VERSION = '1.00'

      CLEANSE_ADDRESS_ENDPOINT = "CleansePlus/Interactive/Cleanse/v#{API_VERSION}/json.ws"

      def address_candidates_for(address, options = {})
        options.merge!('Address' => address)
        perform_with_objects(
          :get,
          CLEANSE_ADDRESS_ENDPOINT,
          options,
          PostcodeAnywhere::CleansePlus::CleansedAddress
        )
      end
    end
  end
end
