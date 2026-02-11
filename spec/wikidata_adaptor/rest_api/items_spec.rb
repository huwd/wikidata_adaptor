# frozen_string_literal: true

require "wikidata_adaptor/rest_api"
require "wikidata_adaptor/test_helpers/rest_api"
require "spec_helper"

RSpec.describe WikidataAdaptor::RestApi::Items do
  include WikidataAdaptor::TestHelpers::RestApi

  let(:endpoint) { "https://test.test/w/rest.php/wikibase" }
  let(:api_client) { WikidataAdaptor::RestApi.new(endpoint) }
  let(:item_id) { "Q42" }

  describe "#get_item" do
    let(:invalid_item_id) { "Bloop" }

    it "gets a wikidata item with expected keys based on the item's ID" do
      stub_get_item(item_id)
      expect(api_client.get_item(item_id).parsed_content.keys).to eq(
        %w[id type labels descriptions aliases statements sitelinks]
      )
    end

    it "raises a 400 response status for an invalid request" do
      stub_get_item_invalid_item("Bloop")
      expect { api_client.get_item("Bloop") }.to raise_error(ApiAdaptor::HTTPBadRequest)
    end

    it "raises a 404 response status if the item cannot be found" do
      stub_get_item_not_found(item_id)
      expect { api_client.get_item(item_id) }.to raise_error(ApiAdaptor::HTTPNotFound)
    end

    it "raises a 500 response status if there's an unexpected error" do
      stub_get_item_unexpected_error(item_id)
      expect { api_client.get_item(item_id) }.to raise_error(ApiAdaptor::HTTPInternalServerError)
    end
  end

  describe "#post_item" do
    it "creates a new item" do
      stub_post_item(posted_item_payload_fixture)
      expect(api_client.post_item(posted_item_payload_fixture).parsed_content).to eq(
        posted_item_response_fixture
      )
    end

    it "raises a 400 response status for an invalid request" do
      stub_post_item_invalid_item
      expect { api_client.post_item({}) }.to raise_error(ApiAdaptor::HTTPBadRequest)
    end

    it "raises a 403 response status if access is denied" do
      stub_post_item_access_denied
      expect { api_client.post_item({}) }.to raise_error(ApiAdaptor::HTTPForbidden)
    end

    it "raises a 422 response status if the edit request violates data policy" do
      stub_post_item_data_policy_violation
      expect { api_client.post_item({}) }.to raise_error(ApiAdaptor::HTTPUnprocessableEntity)
    end

    it "raises a 429 response status if the request limit is exceeded" do
      stub_post_item_request_limit_reached
      expect { api_client.post_item({}) }.to raise_error(ApiAdaptor::HTTPTooManyRequests)
    end

    it "raises a 500 response status if there's an unexpected error" do
      stub_post_item_unexpected_error({})
      expect { api_client.post_item({}) }.to raise_error(ApiAdaptor::HTTPInternalServerError)
    end
  end
end
