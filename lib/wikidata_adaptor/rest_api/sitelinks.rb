# frozen_string_literal: true

module WikidataAdaptor
  class RestApi
    # https://doc.wikimedia.org/Wikibase/master/js/rest-api/#/sitelinks
    module Sitelinks
      # Retrieve an Item's sitelinks.
      #
      # @param [String] item_id The ID of the required Item.
      #
      # @return [Hash] Item's sitelinks by site ID.
      def get_item_sitelinks(item_id)
        get_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}/sitelinks")
      end

      # Retrieve an Item's sitelink for a specific site.
      #
      # @param [String] item_id The ID of the required Item.
      # @param [String] site_id The site identifier (e.g., 'enwiki').
      #
      # @return [Hash] Item's sitelink for the given site.
      def get_item_sitelink(item_id, site_id)
        get_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}/sitelinks/#{CGI.escape(site_id)}")
      end

      # Replace an Item's sitelink for a specific site.
      #
      # @param [String] item_id The ID of the Item.
      # @param [String] site_id The site identifier (e.g., 'enwiki').
      # @param [Hash] payload Sitelink value and edit metadata.
      #
      # @return [Hash] The new sitelink.
      def put_item_sitelink(item_id, site_id, payload)
        put_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}/sitelinks/#{CGI.escape(site_id)}", payload)
      end
    end
  end
end
