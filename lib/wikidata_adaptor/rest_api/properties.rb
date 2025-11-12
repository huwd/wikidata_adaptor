# frozen_string_literal: true

module WikidataAdaptor
  class RestApi
    # https://doc.wikimedia.org/Wikibase/master/js/rest-api/#/properties
    module Properties
      # Retrieve a single Wikibase Property by ID.
      #
      # @param [String] property_id The ID of the required Property.
      #
      # @return [Hash] A single Wikibase Property.
      def get_property(property_id)
        get_json("#{endpoint}/entities/properties/#{CGI.escape(property_id)}")
      end
    end
  end
end
