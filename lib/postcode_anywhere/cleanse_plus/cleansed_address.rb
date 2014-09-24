require 'postcode_anywhere/model_base'

module PostcodeAnywhere
  module CleansePlus
    class CleansedAddress < PostcodeAnywhere::ModelBase
      # The Royal Mail UDPRN (Unique Delivery Point Reference Number) for the address.
      # Example: 26742632
      attr_reader :udprn

      # The name of the company.
      # Example: Postcode Anywhere (Europe) Ltd
      attr_reader :company

      # Department name (rarely used).
      attr_reader :department

      # Line 1 of the address.
      # Example: Enigma House
      attr_reader :line1

      # Line 2 of the address.
      # Example: Elgar Business Centre
      attr_reader :line2

      # Line 3 of the address (rarely used).
      # Example: Moseley Road
      attr_reader :line3

      # Line 4 of the address (rarely used).
      # Example: Hallow
      attr_reader :line4

      # Line 5 of the address (rarely used).
      attr_reader :line5

      # The post town for the address.
      # Example: Worcester
      attr_reader :post_town

      # The postal county for the address.
      # Example: Worcestershire
      attr_reader :county

      # The postcode for the address.
      # Example: WR2 6NJ
      attr_reader :postcode

      # The mailsort code for the address.
      # Example: 70122
      attr_reader :mailsort

      # The barcode for the address.
      # Example: (WR26NJ3UT)
      attr_reader :barcode

      # The type of address.
      # Example: SmallBusiness
      # Values:
      #   - Residential
      #   - SmallBusiness
      #   - LargeBusiness
      #   - Unknown
      attr_reader :type

      # The 2 character delivery point suffix.
      # Example: 3U
      attr_reader :delivery_point_suffix

      # The name of the sub building (flat / unit etc).
      # Example: Enigma House
      attr_reader :sub_building

      # The building name if present.
      # Elgar Business Centre
      attr_reader :building_name

      # The number (or number range) of the building.
      attr_reader :building_number

      # The primary thoroughfare name.
      # Example: Moseley Road
      attr_reader :primary_street

      # The secondary thoroughfare name. Usually a small street off the primary.
      attr_reader :secondary_street

      # The least significant locality (rarely used), possibly a hamlet.
      attr_reader :double_dependent_locality

      # Less significant locality name, possibly a village.
      # Example: Hallow
      attr_reader :dependent_locality

      # The number of the PO Box if present (may contain non numeric items).
      attr_reader :po_box
    end
  end
end
