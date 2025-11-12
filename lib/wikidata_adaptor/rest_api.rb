# frozen_string_literal: true

# Adapter for the wikibase REST API
#
# @see https://doc.wikimedia.org/Wikibase/master/js/rest-api/
module WikidataAdaptor
  # Wikidata REST API class
  class RestApi < ApiAdaptor::Base
    require_relative "rest_api/items"
    require_relative "rest_api/sitelinks"
    require_relative "rest_api/properties"
    require_relative "rest_api/labels"
    require_relative "rest_api/descriptions"
    require_relative "rest_api/aliases"
    include WikidataAdaptor::RestApi::Items
    include WikidataAdaptor::RestApi::Sitelinks
    include WikidataAdaptor::RestApi::Properties
    include WikidataAdaptor::RestApi::Labels
    include WikidataAdaptor::RestApi::Descriptions
    include WikidataAdaptor::RestApi::Aliases

    # Retrieve Statements from an Item.
    #
    # @param [String] The ID of the required Item.
    # @param [String] The ID of the required Statement.
    #
    # @return [Hash] The statements of an Item.
    def get_item_statements(item_id)
      get_json("#{endpoint}/entities/items/#{CGI.escape(item_id)}/statements")
    end

    # Retrieve a single Statement from an Item.
    #
    # @param [String] The ID of the required Item.
    # @param [String] The ID of the required Statement.
    #
    # @return [Hash] A single Wikibase Statement.
    def get_item_statement(item_id, statement_id)
      get_json("#{endpoint}/entities/items/#{CGI.escape(item_id)}/statements/#{statement_id}")
    end

    # Retrieve a single Statement from an Item.
    #
    # @param [String] The ID of the required Statement.
    #
    # @return [Hash] A single Wikibase Statement.
    def get_statement(statement_id)
      get_json("#{endpoint}/statements/#{statement_id}")
    end

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

    # Retrieve Statements from a Property.
    #
    # @param [String] The ID of the required Property.
    #
    # @return [Hash] The statements of a Property.
    def get_property_statements(property_id)
      get_json("#{endpoint}/entities/properties/#{CGI.escape(property_id)}/statements")
    end

    # Retrieve a single Statement from a Property.
    #
    # @param [String] The ID of the required Property.
    # @param [String] The ID of the required Statement.
    #
    # @return [Hash] A single Wikibase Statement.
    def get_property_statement(property_id, statement_id)
      get_json("#{endpoint}/entities/properties/#{CGI.escape(property_id)}/statements/#{statement_id}")
    end
  end
end
