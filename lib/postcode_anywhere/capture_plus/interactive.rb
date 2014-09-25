require 'postcode_anywhere/utils'
require 'postcode_anywhere/capture_plus/search_result'
require 'postcode_anywhere/capture_plus/query_type'

module PostcodeAnywhere
  module CapturePlus
    module Interactive
      include ::PostcodeAnywhere::Utils

      API_VERSION = '2.00'

      FIND_ADDRESSES_ENDPOINT = "CapturePlus/Interactive/Find/v#{API_VERSION}/json.ws"

      def query(search_term, options = {})
        options.merge!(
          'SearchTerm' => search_term
        )
        options['LastId'] = ParentIdExtractor.new(options.delete(:parent_query)).extract
        options['SearchFor'] = options.delete(:search_for) || EVERYTHING
        options['Country']   = options.delete(:country) || 'GBR'
        options['LanguagePreference'] = options.delete(:language) || 'EN'
        perform_with_objects(
          :get,
          FIND_ADDRESSES_ENDPOINT,
          options,
          PostcodeAnywhere::CapturePlus::SearchResult
        )
      end

      def sub_query(search_term, parent_query, options = {})
        options.merge!(parent_query: parent_query)
        query(search_term, options)
      end

      def query_places(search_term, options = {})
        options.merge!(search_for: PLACE)
        query search_term, options
      end

      def query_companies(search_term, options = {})
        options.merge!(search_for: COMPANY)
        query search_term, options
      end

      def query_postcodes(search_term, options = {})
        options.merge!(search_for: POSTCODE)
        query search_term, options
      end

      class ParentIdExtractor
        attr_accessor :parent_query

        def initialize(parent)
          @parent_query = parent
        end

        def extract
          if @parent_query &&
             @parent_query.class == PostcodeAnywhere::CapturePlus::SearchResult
            return @parent_query.id
          else
            return @parent_query
          end
        end
      end
    end
  end
end
