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

  describe "#post_property" do
    it "creates a new property" do
      stub_post_property(posted_property_payload_fixture)
      expect(api_client.post_property(posted_property_payload_fixture).parsed_content).to eq(
        posted_property_response_fixture
      )
    end

    it "raises a 400 response status for an invalid request" do
      stub_post_property_invalid_property
      expect { api_client.post_property({}) }.to raise_error(ApiAdaptor::HTTPBadRequest)
    end

    it "raises a 403 response status if access is denied" do
      stub_post_property_access_denied
      expect { api_client.post_property({}) }.to raise_error(ApiAdaptor::HTTPForbidden)
    end

    it "raises a 422 response status if the edit request violates data policy" do
      stub_post_property_data_policy_violation
      expect { api_client.post_property({}) }.to raise_error(ApiAdaptor::HTTPUnprocessableEntity)
    end

    it "raises a 429 response status if the request limit is exceeded" do
      stub_post_property_request_limit_reached
      expect { api_client.post_property({}) }.to raise_error(ApiAdaptor::HTTPTooManyRequests)
    end

    it "raises a 500 response status if there's an unexpected error" do
      stub_post_property_unexpected_error({})
      expect { api_client.post_property({}) }.to raise_error(ApiAdaptor::HTTPInternalServerError)
    end
  end

  describe "#patch_property" do
    let(:payload) do
      {
        "patch" => [{ "op" => "replace", "path" => "/labels/en", "value" => "is instance of" }],
        "comment" => "Patch property"
      }
    end

    it "patches a property and returns the updated property" do
      stub_patch_property(property_id, payload)
      response = api_client.patch_property(property_id, payload).parsed_content
      expect(response.keys).to include("id", "type", "labels", "descriptions", "aliases", "statements")
    end

    it "raises a 500 response status if there's an unexpected error" do
      stub_patch_property_unexpected_error(property_id, payload)
      expect { api_client.patch_property(property_id, payload) }
        .to raise_error(ApiAdaptor::HTTPInternalServerError)
    end
  end
end
