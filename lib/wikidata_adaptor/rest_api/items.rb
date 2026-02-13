# frozen_string_literal: true

module WikidataAdaptor
  class RestApi
    # https://doc.wikimedia.org/Wikibase/master/js/rest-api/#/items
    module Items
      # Retrieve a single Wikibase Item by ID
      #
      # @param [String] item_id The ID of the required Item.
      #
      # @return [Hash] A single Wikibase Item.
      def get_item(item_id)
        get_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}")
      end

      # Create a Wikibase Item
      #
      # @param [Hash] payload Item containing a Wikibase Item and edit metadata
      #
      # @return [Hash] A single Wikibase Item.
      def post_item(payload)
        post_json("#{endpoint}/v1/entities/items", payload)
      end

      # Apply JSON Patch operations to an Item.
      #
      # @param [String] item_id The ID of the Item.
      # @param [Hash] payload JSON Patch operations and edit metadata.
      #
      # @return [Hash] The updated Item.
      def patch_item(item_id, payload)
        patch_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}", payload)
      end
    end
  end
end
