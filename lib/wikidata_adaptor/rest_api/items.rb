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
    end
  end
end
