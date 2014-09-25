require 'postcode_anywhere/client'
require 'postcode_anywhere/capture_plus/interactive'

module PostcodeAnywhere
  module CapturePlus
    class Client < ::PostcodeAnywhere::Client
      include PostcodeAnywhere::CapturePlus::Interactive
      def initialize(options = {})
        super(options)
      end
    end
  end
end
