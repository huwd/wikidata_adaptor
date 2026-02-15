# frozen_string_literal: true

require "api_adaptor"

require_relative "wikidata_adaptor/version"
require_relative "wikidata_adaptor/rest_api"

module WikidataAdaptor
  # Base error class for WikidataAdaptor exceptions
  class Error < StandardError; end

  # Get the Wikibase REST API endpoint URL
  #
  # Reads from the WIKIBASE_REST_ENDPOINT environment variable,
  # defaulting to the production Wikidata endpoint.
  #
  # @return [String] The base URL for the Wikibase REST API
  def self.rest_endpoint
    ENV["WIKIBASE_REST_ENDPOINT"] || "https://www.wikidata.org/w/rest.php/wikibase"
  end

  # Creates a WikidataAdaptor::RestApi adapter
  #
  # @return [WikidataAdaptor::RestApi]
  def self.rest_api
    WikidataAdaptor::RestApi.new(rest_endpoint)
  end
end
