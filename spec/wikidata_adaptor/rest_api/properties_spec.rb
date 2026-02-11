# frozen_string_literal: true

require "wikidata_adaptor/rest_api"
require "wikidata_adaptor/test_helpers/rest_api"
require "spec_helper"

RSpec.describe WikidataAdaptor::RestApi::Properties do
  include WikidataAdaptor::TestHelpers::RestApi

  let(:endpoint) { "https://test.test/w/rest.php/wikibase" }
  let(:api_client) { WikidataAdaptor::RestApi.new(endpoint) }
  let(:property_id) { "P31" }

  describe "#get_property" do
    it "gets a wikidata property based on the property's ID" do
      stub_get_property(property_id)
      expect(api_client.get_property(property_id).parsed_content.keys).to include(
        "id", "type", "labels", "descriptions", "aliases", "statements"
      )
    end

    it "raises a 400 response status for an invalid request" do
      stub_get_property_invalid_property("BadProp")
      expect { api_client.get_property("BadProp") }.to raise_error(ApiAdaptor::HTTPBadRequest)
    end

    it "raises a 404 response status if the property cannot be found" do
      stub_get_property_not_found(property_id)
      expect { api_client.get_property(property_id) }.to raise_error(ApiAdaptor::HTTPNotFound)
    end

    it "raises a 500 response status if there's an unexpected error" do
      stub_get_property_unexpected_error(property_id)
      expect { api_client.get_property(property_id) }.to raise_error(ApiAdaptor::HTTPInternalServerError)
    end
  end
end
