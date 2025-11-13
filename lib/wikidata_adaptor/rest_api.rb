# frozen_string_literal: true

# Adapter for the wikibase REST API
#
# @see https://doc.wikimedia.org/Wikibase/master/js/rest-api/
module WikidataAdaptor
  # Wikidata REST API class
  class RestApi < ApiAdaptor::Base
    require_relative "rest_api/open_api_document"
    require_relative "rest_api/items"
    require_relative "rest_api/sitelinks"
    require_relative "rest_api/properties"
    require_relative "rest_api/labels"
    require_relative "rest_api/descriptions"
    require_relative "rest_api/aliases"
    require_relative "rest_api/statements"
    include WikidataAdaptor::RestApi::OpenApiDocument
    include WikidataAdaptor::RestApi::Items
    include WikidataAdaptor::RestApi::Sitelinks
    include WikidataAdaptor::RestApi::Properties
    include WikidataAdaptor::RestApi::Labels
    include WikidataAdaptor::RestApi::Descriptions
    include WikidataAdaptor::RestApi::Aliases
    include WikidataAdaptor::RestApi::Statements

    # Retrieve an Item's sitelinks.
    #
    # @param [String] item_id The ID of the required Item.
    #
    # @return [Hash] Item's sitelinks by site ID.
    def get_item_sitelinks(item_id)
      get_json("#{endpoint}/entities/items/#{CGI.escape(item_id)}/sitelinks")
    end

    # Retrieve an Item's sitelink for a specific site.
    #
    # @param [String] The ID of the required Item.
    # @param [String] The site identifier (e.g., 'enwiki').
    #
    # @return [Hash] Item's sitelink for the given site.
    def get_item_sitelink(item_id, site_id)
      get_json("#{endpoint}/entities/items/#{CGI.escape(item_id)}/sitelinks/#{CGI.escape(site_id)}")
    end
  end
end
