# frozen_string_literal: true

require "wikidata_adaptor/rest_api"
require "wikidata_adaptor/test_helpers/rest_api"
require "spec_helper"

RSpec.describe WikidataAdaptor::RestApi::OpenApiDocument do
  include WikidataAdaptor::TestHelpers::RestApi

  let(:endpoint) { "https://test.test/w/rest.php/wikibase/v0" }
  let(:api_client) { WikidataAdaptor::RestApi.new(endpoint) }

  describe "#get_openapi_document" do
    it "retrieves the OpenAPI document" do
      stub_get_openapi_document
      expect(api_client.get_openapi_document.parsed_content).to include(
        "openapi", "info", "paths"
      )
    end
  end
end
