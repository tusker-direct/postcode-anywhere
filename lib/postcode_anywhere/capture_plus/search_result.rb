require 'postcode_anywhere/model_base'

module PostcodeAnywhere
  module CapturePlus
    class SearchResult < PostcodeAnywhere::ModelBase
      # The Id to be used as the LastId with the Find method.
      # Example: GBR|ST|27299|3739|6|0|0|
      attr_reader :id

      # The found item.
      # Example: High Street, London
      attr_reader :text

      # A list of number ranges identifying the characters to highlight
      # in the Text response (zero-based start position and end).
      # Example: 0-2,6-4
      attr_reader :highlight

      # A zero-based position in the Text response indicating the suggested
      # position of the cursor if this item is selected.
      # A -1 response indicates no suggestion is available.
      # 0
      # Example: true
      attr_reader :cursor

      # Descriptive information about the found item, typically if it's a container.
      # Example: 102 Streets
      attr_reader :description

      # The next step of the search process.
      # Values:
      #   - Find
      #   - Retrieve
      #   - None
      # Example: Retrieve
      attr_reader :next
    end
  end
end
