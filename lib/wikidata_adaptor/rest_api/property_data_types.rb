# frozen_string_literal: true

module WikidataAdaptor
  class RestApi
    # https://doc.wikimedia.org/Wikibase/master/js/rest-api/#/Property%20data%20types
    module PropertyDataTypes
      # Retrieve the map of Property data types to value types
      #
      # @return [Hash] The map of Property data types to value types
      def get_property_data_types
        get_json("#{endpoint}/property-data-types")
      end
    end
  end
end
