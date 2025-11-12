# frozen_string_literal: true

module WikidataAdaptor
  class RestApi
    # https://doc.wikimedia.org/Wikibase/master/js/rest-api/#/descriptions
    module Descriptions
      # Retrieve an Item's descriptions.
      #
      # @param [String] item_id The ID of the required Item.
      #
      # @return [Hash] Item's descriptions by language.
      def get_item_descriptions(item_id)
        get_json("#{endpoint}/entities/items/#{CGI.escape(item_id)}/descriptions")
      end

      # Retrieve an Item's description in a specific language.
      #
      # @param [String] item_id The ID of the required Item.
      # @param [String] lang_code The requested resource language.
      #
      # @return [String] Item's description in a specific language.
      def get_item_description(item_id, lang_code)
        get_json("#{endpoint}/entities/items/#{CGI.escape(item_id)}/descriptions/#{lang_code}")
      end

      # Retrieve a Property's descriptions.
      #
      # @param [String] property_id The ID of the required Property.
      #
      # @return [Hash] Property's descriptions by language.
      def get_property_descriptions(property_id)
        get_json("#{endpoint}/entities/properties/#{CGI.escape(property_id)}/descriptions")
      end

      # Retrieve a Property's description in a specific language.
      #
      # @param [String] property_id The ID of the required Property.
      # @param [String] lang_code The requested resource language.
      #
      # @return [String] Property's description in a specific language.
      def get_property_description(property_id, lang_code)
        get_json("#{endpoint}/entities/properties/#{CGI.escape(property_id)}/descriptions/#{lang_code}")
      end
    end
  end
end
