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
        get_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}/descriptions")
      end

      # Retrieve an Item's description in a specific language.
      #
      # @param [String] item_id The ID of the required Item.
      # @param [String] lang_code The requested resource language.
      #
      # @return [String] Item's description in a specific language.
      def get_item_description(item_id, lang_code)
        get_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}/descriptions/#{lang_code}")
      end

      # Retrieve an Item's description in a specific language, using Wikibase language fallback.
      #
      # NOTE: The OpenAPI spec documents that this endpoint may respond with a redirect
      # (e.g. 307/308) and a Location header. api_adaptor v0.1.0+ follows these
      # redirects.
      #
      # @param [String] item_id The ID of the required Item.
      # @param [String] lang_code The requested resource language.
      #
      # @return [String] Item's description in a specific language.
      def get_item_description_with_language_fallback(item_id, lang_code)
        get_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}/descriptions_with_language_fallback/#{lang_code}")
      end

      # Retrieve a Property's descriptions.
      #
      # @param [String] property_id The ID of the required Property.
      #
      # @return [Hash] Property's descriptions by language.
      def get_property_descriptions(property_id)
        get_json("#{endpoint}/v1/entities/properties/#{CGI.escape(property_id)}/descriptions")
      end

      # Retrieve a Property's description in a specific language.
      #
      # @param [String] property_id The ID of the required Property.
      # @param [String] lang_code The requested resource language.
      #
      # @return [String] Property's description in a specific language.
      def get_property_description(property_id, lang_code)
        get_json("#{endpoint}/v1/entities/properties/#{CGI.escape(property_id)}/descriptions/#{lang_code}")
      end

      # Retrieve a Property's description in a specific language, using Wikibase language fallback.
      #
      # NOTE: The OpenAPI spec documents that this endpoint may respond with a redirect
      # (e.g. 307/308) and a Location header. api_adaptor v0.1.0+ follows these
      # redirects.
      #
      # @param [String] property_id The ID of the required Property.
      # @param [String] lang_code The requested resource language.
      #
      # @return [String] Property's description in a specific language.
      def get_property_description_with_language_fallback(property_id, lang_code)
        get_json("#{endpoint}/v1/entities/properties/#{CGI.escape(property_id)}/descriptions_with_language_fallback/#{lang_code}")
      end

      # Replace an Item's description in a specific language.
      #
      # @param [String] item_id The ID of the Item.
      # @param [String] lang_code The language code.
      # @param [Hash] payload Description value and edit metadata.
      #
      # @return [String] The new description value.
      def put_item_description(item_id, lang_code, payload)
        put_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}/descriptions/#{lang_code}", payload)
      end

      # Replace a Property's description in a specific language.
      #
      # @param [String] property_id The ID of the Property.
      # @param [String] lang_code The language code.
      # @param [Hash] payload Description value and edit metadata.
      #
      # @return [String] The new description value.
      def put_property_description(property_id, lang_code, payload)
        put_json("#{endpoint}/v1/entities/properties/#{CGI.escape(property_id)}/descriptions/#{lang_code}", payload)
      end
    end
  end
end
