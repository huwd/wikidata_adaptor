# frozen_string_literal: true

require "wikidata_adaptor/rest_api"
require "wikidata_adaptor/test_helpers/rest_api"
require "spec_helper"

RSpec.describe WikidataAdaptor::RestApi do
  include WikidataAdaptor::TestHelpers::RestApi

  let(:endpoint) { "https://test.test/w/rest.php/wikibase/v0" }
  let(:api_client) { WikidataAdaptor::RestApi.new(endpoint) }
  let(:item_id) { "Q42" }
  let(:statement_id) { "Q42$F078E5B3-F9A8-480E-B7AC-D97778CBBEF9" }
  let(:property_id) { "P31" }

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
                                                                                          "id" => statement_id.to_s,
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
                                                                            "id" => statement_id.to_s,
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

  describe "#get_property_labels" do
    it "gets property labels in all locales by property_id" do
      stub_get_property_labels(property_id)
      expect(api_client.get_property_labels(property_id).parsed_content).to eq({
                                                                                 "en" => "instance of",
                                                                                 "fr" => "est un(e)"
                                                                               })
    end
  end

  describe "#get_property_label" do
    it "gets a property label by property_id in a specific locale" do
      stub_get_property_label(property_id, "en")
      expect(api_client.get_property_label(property_id, "en").raw_response_body).to eq("instance of")
    end
  end

  describe "#get_property_descriptions" do
    it "gets property descriptions in all locales by property_id" do
      stub_get_property_descriptions(property_id)
      expect(api_client.get_property_descriptions(property_id).parsed_content).to eq({
                                                                                       "en" => "that class of which this subject is a particular example and member",
                                                                                       "fr" => "classe dont ce sujet est un exemple particulier"
                                                                                     })
    end
  end

  describe "#get_property_description" do
    it "gets a property description by property_id in a specific locale" do
      stub_get_property_description(property_id, "en")
      expect(api_client.get_property_description(property_id, "en").raw_response_body).to eq(
        "that class of which this subject is a particular example and member"
      )
    end
  end

  describe "#get_property_aliases" do
    it "gets property aliases in all locales by property_id" do
      stub_get_property_aliases(property_id)
      expect(api_client.get_property_aliases(property_id).parsed_content).to eq({
                                                                                  "en" => ["is a"],
                                                                                  "fr" => ["est un"]
                                                                                })
    end
  end

  describe "#get_property_alias" do
    it "gets property aliases in a specific locale" do
      stub_get_property_alias(property_id, "en")
      expect(api_client.get_property_alias(property_id, "en").parsed_content).to eq(["is a"])
    end
  end

  describe "#get_property_statements" do
    it "gets all the statements related to a property identified by property_id" do
      stub_get_property_statements(property_id, { "P31" => [] })
      expect(api_client.get_property_statements(property_id).parsed_content).to eq({ "P31" => [] })
    end
  end

  describe "#get_property_statement" do
    let(:property_statement_id) { "P31$11111111-2222-3333-4444-555555555555" }

    it "returns a specific statement by property_id and statement_id" do
      stub_get_property_statement(property_id, property_statement_id)
      expect(api_client.get_property_statement(property_id, property_statement_id).parsed_content).to eq({
                                                                                                           "id" => property_statement_id.to_s,
                                                                                                           "rank" => "normal",
                                                                                                           "property" => {
                                                                                                             "id" => property_id.to_s,
                                                                                                             "data-type" => "wikibase-item"
                                                                                                           },
                                                                                                           "value" => {
                                                                                                             "content" => "Q5",
                                                                                                             "type" => "value"
                                                                                                           },
                                                                                                           "qualifiers" => [],
                                                                                                           "references" => []
                                                                                                         })
    end
  end
end
