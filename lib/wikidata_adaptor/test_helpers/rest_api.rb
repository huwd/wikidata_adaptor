# frozen_string_literal: true

require "json"
require "webmock"

module WikidataAdaptor
  module TestHelpers
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
      include WikidataAdaptor::TestHelpers::RestApi::OpenApiDocument
      include WikidataAdaptor::TestHelpers::RestApi::Aliases
      include WikidataAdaptor::TestHelpers::RestApi::Items
      include WikidataAdaptor::TestHelpers::RestApi::Sitelinks
      include WikidataAdaptor::TestHelpers::RestApi::Properties
      include WikidataAdaptor::TestHelpers::RestApi::Labels
      include WikidataAdaptor::TestHelpers::RestApi::Descriptions
      include WikidataAdaptor::TestHelpers::RestApi::Statements
      include WikidataAdaptor::TestHelpers::RestApi::PropertyDataTypes

      WIKIBASE_REST_ENDPOINT = ENV["WIKIBASE_REST_ENDPOINT"] || "https://test.test/w/rest.php/wikibase/v0"

      def stub_rest_api_request(method, path, with: {}, response_status: 200, response_body: {}, session: nil)
        with.merge!(headers: { WikidataAdaptor::RestApi::AUTH_HEADER_NAME => session }) if session
        session = nil if response_status >= 400
        to_return = { status: response_status, body: prepare_response(response_body, session) }
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
