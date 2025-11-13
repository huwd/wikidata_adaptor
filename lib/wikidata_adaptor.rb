# frozen_string_literal: true

require "api_adaptor"

require_relative "wikidata_adaptor/version"
require_relative "wikidata_adaptor/rest_api"

module WikidataAdaptor
  class Error < StandardError; end

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
