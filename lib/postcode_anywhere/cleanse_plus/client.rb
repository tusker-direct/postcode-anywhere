require 'postcode_anywhere/client'
require 'postcode_anywhere/cleanse_plus/interactive'

module PostcodeAnywhere
  module CleansePlus
    class Client < ::PostcodeAnywhere::Client
      include PostcodeAnywhere::CleansePlus::Interactive
      def initialize(options = {})
        super(options)
      end
    end
  end
end
