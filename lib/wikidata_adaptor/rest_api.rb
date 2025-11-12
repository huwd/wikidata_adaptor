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
    include WikidataAdaptor::RestApi::Items
    include WikidataAdaptor::RestApi::Sitelinks
    include WikidataAdaptor::RestApi::Properties
    include WikidataAdaptor::RestApi::Labels
    include WikidataAdaptor::RestApi::Descriptions

    # Retrieve an Item's aliases.
    #
    # @param [String] The ID of the required Item.
    #
    # @return [Hash] Item's aliases by language.
    def get_item_aliases(item_id)
      get_json("#{endpoint}/entities/items/#{CGI.escape(item_id)}/aliases")
    end

    # Retrieve an Item's aliases in a specific language.
    #
    # @param [String] The ID of the required Item.
    # @param [String] The requested resource language.
    #
    # @return [Array[String]] Item's aliases in a specific language
    def get_item_alias(item_id, lang_code)
      get_json("#{endpoint}/entities/items/#{CGI.escape(item_id)}/aliases/#{lang_code}")
    end

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

    # Retrieve a Property's aliases.
    #
    # @param [String] The ID of the required Property.
    #
    # @return [Hash] Property's aliases by language.
    def get_property_aliases(property_id)
      get_json("#{endpoint}/entities/properties/#{CGI.escape(property_id)}/aliases")
    end

    # Retrieve a Property's aliases in a specific language.
    #
    # @param [String] The ID of the required Property.
    # @param [String] The requested resource language.
    #
    # @return [Array[String]] Property's aliases in a specific language
    def get_property_alias(property_id, lang_code)
      get_json("#{endpoint}/entities/properties/#{CGI.escape(property_id)}/aliases/#{lang_code}")
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
