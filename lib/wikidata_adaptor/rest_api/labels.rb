# frozen_string_literal: true

module WikidataAdaptor
  class RestApi
    # https://doc.wikimedia.org/Wikibase/master/js/rest-api/#/labels
    module Labels
      # Retrieve an Item's labels.
      #
      # @param [String] item_id The ID of the required Item.
      #
      # @return [Hash] Item's labels by language.
      def get_item_labels(item_id)
        get_json("#{endpoint}/entities/items/#{CGI.escape(item_id)}/labels")
      end

      # Retrieve an Item's label in a specific language.
      #
      # @param [String] item_id The ID of the required Item.
      # @param [String] lang_code The requested resource language.
      #
      # @return [String] Item's label in a specific language.
      def get_item_label(item_id, lang_code)
        get_json("#{endpoint}/entities/items/#{CGI.escape(item_id)}/labels/#{lang_code}")
      end

      # Retrieve a Property's labels.
      #
      # @param [String] property_id The ID of the required Property.
      #
      # @return [Hash] Property's labels by language.
      def get_property_labels(property_id)
        get_json("#{endpoint}/entities/properties/#{CGI.escape(property_id)}/labels")
      end

      # Retrieve a Property's label in a specific language.
      #
      # @param [String] property_id The ID of the required Property.
      # @param [String] lang_code The requested resource language.
      #
      # @return [String] Property's label in a specific language.
      def get_property_label(property_id, lang_code)
        get_json("#{endpoint}/entities/properties/#{CGI.escape(property_id)}/labels/#{lang_code}")
      end
    end
  end
end
