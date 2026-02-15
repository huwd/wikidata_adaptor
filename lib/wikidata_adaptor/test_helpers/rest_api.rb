# frozen_string_literal: true

require "json"
require "webmock"

module WikidataAdaptor
  # Test helpers for stubbing WikidataAdaptor API calls in tests
  module TestHelpers
    # WebMock stubs for the Wikibase REST API
    #
    # Include this module in your RSpec tests to access stub methods
    # for all Wikibase REST API endpoints.
    #
    # @example
    #   RSpec.describe MyClass do
    #     include WikidataAdaptor::TestHelpers::RestApi
    #
    #     it "fetches an item" do
    #       stub_get_item("Q42")
    #       # ...
    #     end
    #   end
    module RestApi
      require_relative "rest_api/open_api_document"
      require_relative "rest_api/aliases"
      require_relative "rest_api/items"
      require_relative "rest_api/sitelinks"
      require_relative "rest_api/properties"
      require_relative "rest_api/labels"
      require_relative "rest_api/descriptions"
      require_relative "rest_api/statements"
      require_relative "rest_api/property_data_types"
      require_relative "rest_api/search_item"
      require_relative "rest_api/search_property"
      include WikidataAdaptor::TestHelpers::RestApi::OpenApiDocument
      include WikidataAdaptor::TestHelpers::RestApi::Aliases
      include WikidataAdaptor::TestHelpers::RestApi::Items
      include WikidataAdaptor::TestHelpers::RestApi::Sitelinks
      include WikidataAdaptor::TestHelpers::RestApi::Properties
      include WikidataAdaptor::TestHelpers::RestApi::Labels
      include WikidataAdaptor::TestHelpers::RestApi::Descriptions
      include WikidataAdaptor::TestHelpers::RestApi::Statements
      include WikidataAdaptor::TestHelpers::RestApi::PropertyDataTypes
      include WikidataAdaptor::TestHelpers::RestApi::SearchItem
      include WikidataAdaptor::TestHelpers::RestApi::SearchProperty

      # Default test endpoint for stubbed requests
      WIKIBASE_REST_ENDPOINT = ENV["WIKIBASE_REST_ENDPOINT"] || "https://test.test/w/rest.php/wikibase"

      # Stub a Wikibase REST API request with WebMock
      #
      # This is the base method used by all specific stub_* helpers.
      # Use the specific stub methods instead of calling this directly.
      #
      # @param [Symbol] method HTTP method (:get, :post, :put, :patch, :delete)
      # @param [String] path API path (e.g., "/v1/entities/items/Q42")
      # @param [Hash] with Optional request matching criteria
      # @param [Integer] response_status HTTP status code to return
      # @param [Hash] response_headers HTTP headers to return
      # @param [Hash, Array, String] response_body Response body
      # @param [String, nil] session Optional session token
      #
      # @return [WebMock::RequestStub] The configured stub
      def stub_rest_api_request(method, path, with: {}, response_status: 200, response_headers: {}, response_body: {}, session: nil)
        with.merge!(headers: { WikidataAdaptor::RestApi::AUTH_HEADER_NAME => session }) if session
        session = nil if response_status >= 400
        to_return = { status: response_status, headers: response_headers, body: prepare_response(response_body, session) }
        if with.empty?
          stub_request(method, "#{WIKIBASE_REST_ENDPOINT}#{path}").to_return(**to_return)
        else
          stub_request(method, "#{WIKIBASE_REST_ENDPOINT}#{path}").with(**with).to_return(**to_return)
        end
      end

      private

      def prepare_response(response_body, session)
        case response_body
        when Hash
          response_body.merge(session: session).compact.to_json
        when Array
          response_body.to_json
        else # String or other
          response_body
        end
      end
    end
  end
end
