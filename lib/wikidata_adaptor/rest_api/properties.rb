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
        get_json("#{endpoint}/v1/entities/properties/#{CGI.escape(property_id)}")
      end

      # Create a Wikibase Property.
      #
      # @param [Hash] payload Property containing a Wikibase Property and edit metadata.
      #
      # @return [Hash] A single Wikibase Property.
      def post_property(payload)
        post_json("#{endpoint}/v1/entities/properties", payload)
      end

      # Apply JSON Patch operations to a Property.
      #
      # @param [String] property_id The ID of the Property.
      # @param [Hash] payload JSON Patch operations and edit metadata.
      #
      # @return [Hash] The updated Property.
      def patch_property(property_id, payload)
        patch_json("#{endpoint}/v1/entities/properties/#{CGI.escape(property_id)}", payload)
      end
    end
  end
end
