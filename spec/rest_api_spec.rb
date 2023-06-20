require "wikidata_adaptor/rest_api"
require "wikidata_adaptor/test_helpers/rest_api"
require "spec_helper"

RSpec.describe WikidataAdaptor::RestApi do
  include WikidataAdaptor::TestHelpers::RestApi
  let(:endpoint) { WikidataAdaptor.rest_endpoint }
  let(:api_client) { WikidataAdaptor::RestApi.new(endpoint) }
  let(:item_id) { "Q42" }
  let(:statement_id) { "Q42$F078E5B3-F9A8-480E-B7AC-D97778CBBEF9" }

  describe "#get_item" do
    let(:invalid_item_id) { "Bloop" }

    it "gets a wikidata item based on the item's ID" do
      stub_get_item(item_id)
      expect(api_client.get_item(item_id).parsed_content.keys).to eq(
        %w[id type labels descriptions aliases sitelinks statements]
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

  describe "#get_item_labels" do
    it "gets item labels in all locales by item_id" do
      stub_get_item_labels(item_id)
      expect(api_client.get_item_labels(item_id).parsed_content).to eq({
        "en" => "Douglas Adams",
        "fr" => "Douglas Adams"
      })
    end
  end

  describe "#get_item_label" do
    it "gets an item label by item_id in a specific locale" do
      stub_get_item_label(item_id, "en")
      expect(api_client.get_item_label(item_id, "en").raw_response_body).to eq("Douglas Adams")
    end
  end

  describe "#get_item_descriptions" do
    it "gets item descriptions in all locales by item_id" do
      stub_get_item_descriptions(item_id)
      expect(api_client.get_item_descriptions(item_id).parsed_content).to eq({
        "en" => "English science fiction writer and humourist",
        "fr" => "écrivain de science-fiction et humoriste anglais"
      })
    end
  end

  describe "#get_item_description" do
    it "gets an item description by item_id in a specific locale" do
      stub_get_item_description(item_id, "en")
      expect(api_client.get_item_description(item_id, "en").raw_response_body).to eq(
        "English science fiction writer and humourist"
      )
    end
  end

  describe "#get_item_aliases" do
    it "gets item aliases in all locales by item_id" do
      stub_get_item_aliases(item_id)
      expect(api_client.get_item_aliases(item_id).parsed_content).to eq({
        "en" => [
          "Douglas Noel Adams",
          "Douglas Noël Adams"
        ],
        "fr" => [
          "Douglas Noel Adams"
        ]
      })
    end
  end

  describe "#get_item_alias" do
    it "gets an item alias by item_id in a specific locale" do
      stub_get_item_alias(item_id, "en")
      expect(api_client.get_item_alias(item_id, "en").parsed_content).to eq([
        "Douglas Noel Adams",
        "Douglas Noël Adams"
      ])
    end
  end

  describe "#get_item_statements" do
    it "gets all the statements related to an item identified by item_id" do
      stub_get_item_statements(item_id)
      expect(api_client.get_item_statements(item_id).parsed_content.keys).to eq(
        %w[additionalProp1 additionalProp2 additionalProp3]
      )
    end

    it "has a test helper that allows you to submit your own response to test" do
      stub_get_item_statements(item_id, { "foo" => "bar" })
      expect(api_client.get_item_statements(item_id).parsed_content).to eq({
        "foo" => "bar"
      })
    end
  end

  describe "#get_item_statement" do
    it "returns a specific statement by item_id and statement_id" do
      stub_get_item_statement(item_id, statement_id)
      expect(api_client.get_item_statement(item_id, statement_id).parsed_content).to eq({
        "id" => "#{statement_id}",
        "rank" => "normal",
        "property" => {
          "id" => "P92",
          "data-type" => "string"
        },
        "value" => {
          "content" => "I am a goat",
          "type" => "value"
        },
        "qualifiers" => [],
        "references" => []
      })
    end
  end

  describe "#get_statement" do
    it "returns a specific statement statement_id" do
      stub_get_statement(statement_id)
      expect(api_client.get_statement(statement_id).parsed_content).to eq({
        "id" => "#{statement_id}",
        "rank" => "normal",
        "property" => {
          "id" => "P92",
          "data-type" => "string"
        },
        "value" => {
          "content" => "I am a goat",
          "type" => "value"
        },
        "qualifiers" => [],
        "references" => []
      })
    end
  end
end