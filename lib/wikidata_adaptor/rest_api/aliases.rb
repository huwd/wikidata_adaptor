# frozen_string_literal: true

module WikidataAdaptor
  class RestApi
    # https://doc.wikimedia.org/Wikibase/master/js/rest-api/#/aliases
    module Aliases
      # Retrieve an Item's aliases.
      #
      # @param [String] item_id The ID of the required Item.
      #
      # @return [Hash] Item's aliases by language.
      def get_item_aliases(item_id)
        get_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}/aliases")
      end

      # Retrieve an Item's alias in a specific language.
      #
      # @param [String] item_id The ID of the required Item.
      # @param [String] lang_code The requested resource language.
      #
      # @return [Array[String]] Item's alias in a specific language.
      def get_item_alias(item_id, lang_code)
        get_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}/aliases/#{lang_code}")
      end

      # Retrieve a Property's aliases.
      #
      # @param [String] property_id The ID of the required Property.
      #
      # @return [Hash] Property's aliases by language.
      def get_property_aliases(property_id)
        get_json("#{endpoint}/v1/entities/properties/#{CGI.escape(property_id)}/aliases")
      end

      # Retrieve a Property's aliases in a specific language.
      #
      # @param [String] property_id The ID of the required Property.
      # @param [String] lang_code The requested resource language.
      #
      # @return [Array[String]] Property's aliases in a specific language.
      def get_property_alias(property_id, lang_code)
        get_json("#{endpoint}/v1/entities/properties/#{CGI.escape(property_id)}/aliases/#{lang_code}")
      end
    end
  end
end
