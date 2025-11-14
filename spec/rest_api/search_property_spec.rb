# frozen_string_literal: true

require "wikidata_adaptor/rest_api"
require "wikidata_adaptor/test_helpers/rest_api"
require "spec_helper"

RSpec.describe WikidataAdaptor::RestApi::SearchProperty do
  include WikidataAdaptor::TestHelpers::RestApi

  let(:endpoint) { "https://test.test/w/rest.php/wikibase" }
  let(:api_client) { WikidataAdaptor::RestApi.new(endpoint) }

  describe "#search_properties" do
    it "searches for properties by search term" do
      stub_search_properties("taxon", "en")
      expect(api_client.search_properties("taxon", "en").parsed_content)
        .to eq(
          {
            "results" => [
              {
                "id" => "P123",
                "display-label" => {
                  "language" => "en",
                  "value" => "taxon name"
                },
                "description" => {
                  "language" => "en",
                  "value" => "scientific name of a taxon"
                },
                "match" => {
                  "type" => "label",
                  "language" => "en",
                  "text" => "taxon name"
                }
              },
              {
                "id" => "P234",
                "display-label" => {
                  "language" => "en",
                  "value" => "taxon rank"
                },
                "description" => {
                  "language" => "en",
                  "value" => "level in a taxonomic hierarchy"
                },
                "match" => {
                  "type" => "label",
                  "language" => "en",
                  "text" => "taxon rank"
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

        stub_search_properties("taxon", "en", response_body: custom_response)
        expect(api_client.search_properties("taxon", "en").parsed_content)
          .to eq(custom_response)
      end
    end
  end

  describe "#suggest_items" do
    it "suggestes for items by partial search term" do
      stub_suggest_properties("taxon", "en")
      expect(api_client.suggest_properties("taxon", "en").parsed_content)
        .to eq(
          {
            "results" => [
              {
                "id" => "P123",
                "display-label" => {
                  "language" => "en",
                  "value" => "taxon name"
                },
                "description" => {
                  "language" => "en",
                  "value" => "scientific name of a taxon"
                },
                "match" => {
                  "type" => "label",
                  "language" => "en",
                  "text" => "taxon name"
                }
              },
              {
                "id" => "P234",
                "display-label" => {
                  "language" => "en",
                  "value" => "taxon rank"
                },
                "description" => {
                  "language" => "en",
                  "value" => "level in a taxonomic hierarchy"
                },
                "match" => {
                  "type" => "label",
                  "language" => "en",
                  "text" => "taxon rank"
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

        stub_suggest_properties("taxon", "en", response_body: custom_response)
        expect(api_client.suggest_properties("taxon", "en").parsed_content)
          .to eq(custom_response)
      end
    end
  end
end
