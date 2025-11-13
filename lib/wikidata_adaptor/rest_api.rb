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
    require_relative "rest_api/property_data_types"
    include WikidataAdaptor::RestApi::OpenApiDocument
    include WikidataAdaptor::RestApi::Items
    include WikidataAdaptor::RestApi::Sitelinks
    include WikidataAdaptor::RestApi::Properties
    include WikidataAdaptor::RestApi::Labels
    include WikidataAdaptor::RestApi::Descriptions
    include WikidataAdaptor::RestApi::Aliases
    include WikidataAdaptor::RestApi::Statements
    include WikidataAdaptor::RestApi::PropertyDataTypes
  end
end
