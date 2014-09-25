require 'postcode_anywhere/model_base'

module PostcodeAnywhere
  module CapturePlus
    class RetrieveResult < PostcodeAnywhere::ModelBase
      attr_reader :id
      attr_reader :domestic_id
      attr_reader :language
      attr_reader :language_alternatives
      attr_reader :department
      attr_reader :company
      attr_reader :sub_building
      attr_reader :building_number
      attr_reader :building_name
      attr_reader :secondary_street
      attr_reader :street
      attr_reader :block
      attr_reader :neighbourhood
      attr_reader :district
      attr_reader :city
      attr_reader :line1
      attr_reader :line2
      attr_reader :line3
      attr_reader :line4
      attr_reader :line5
      attr_reader :admin_area_name
      attr_reader :admin_area_code
      attr_reader :province
      attr_reader :province_name
      attr_reader :province_code
      attr_reader :postal_code
      attr_reader :country_name
      attr_reader :country_iso2
      attr_reader :country_iso3
      attr_reader :country_iso_number
      attr_reader :sorting_number1
      attr_reader :sorting_number2
      attr_reader :barcode
      attr_reader :po_box_number
      attr_reader :label
      attr_reader :type
      attr_reader :data_level
    end
  end
end
