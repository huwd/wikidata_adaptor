# frozen_string_literal: true

require "wikidata_adaptor/rest_api"
require "wikidata_adaptor/test_helpers/rest_api"
require "spec_helper"

RSpec.describe WikidataAdaptor::RestApi::SearchItem do
  include WikidataAdaptor::TestHelpers::RestApi

  let(:endpoint) { "https://test.test/w/rest.php/wikibase" }
  let(:api_client) { WikidataAdaptor::RestApi.new(endpoint) }

  describe "#search_items" do
    it "searches for items by search term" do
      stub_search_items("potato", "en")
      expect(api_client.search_items("potato", "en").parsed_content)
        .to eq(
          {
            "results" => [
              {
                "id" => "Q123",
                "display-label" => {
                  "language" => "en",
                  "value" => "potato"
                },
                "description" => {
                  "language" => "en",
                  "value" => "staple food"
                },
                "match" => {
                  "type" => "label",
                  "language" => "en",
                  "text" => "potato"
                }
              },
              {
                "id" => "Q234",
                "display-label" => {
                  "language" => "en",
                  "value" => "potato"
                },
                "description" => {
                  "language" => "en",
                  "value" => "species of plant"
                },
                "match" => {
                  "type" => "label",
                  "language" => "en",
                  "text" => "potato"
                }
              }
            ]
          }
        )
    end

    describe "test stub" do
      it "can return a custom response" do
        custom_response = {
          "foo" => "bar"
        }

        stub_search_items("potato", "en", response_body: custom_response)
        expect(api_client.search_items("potato", "en").parsed_content)
          .to eq(custom_response)
      end
    end
  end

  describe "#suggest_items" do
    it "suggestes for items by partial search term" do
      stub_suggest_items("pota", "en")
      expect(api_client.suggest_items("pota", "en").parsed_content)
        .to eq(
          {
            "results" => [
              {
                "id" => "Q456",
                "display-label" => {
                  "language" => "en",
                  "value" => "drinking water"
                },
                "description" => {
                  "language" => "en",
                  "value" => "water safe for consumption"
                },
                "match" => {
                  "type" => "alias",
                  "language" => "en",
                  "text" => "potable water"
                }
              },
              {
                "id" => "Q123",
                "display-label" => {
                  "language" => "en",
                  "value" => "potato"
                },
                "description" => {
                  "language" => "en",
                  "value" => "staple food"
                },
                "match" => {
                  "type" => "label",
                  "language" => "en",
                  "text" => "potato"
                }
              }
            ]
          }
        )
    end

    describe "test stub" do
      it "can return a custom response" do
        custom_response = {
          "foo" => "bar"
        }

        stub_suggest_items("pota", "en", response_body: custom_response)
        expect(api_client.suggest_items("pota", "en").parsed_content)
          .to eq(custom_response)
      end
    end
  end
end
