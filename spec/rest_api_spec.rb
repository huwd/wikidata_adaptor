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

  describe "#get_item_sitelinks" do
    it "gets item sitelinks by item_id" do
      stub_get_item_sitelinks(item_id)
      expect(api_client.get_item_sitelinks(item_id).parsed_content).to eq({
                                                                            "enwiki" => {
                                                                              "title" => "Douglas Adams",
                                                                              "badges" => [],
                                                                              "url" => "https://en.wikipedia.org/wiki/Douglas_Adams"
                                                                            },
                                                                            "frwiki" => {
                                                                              "title" => "Douglas Adams",
                                                                              "badges" => [],
                                                                              "url" => "https://fr.wikipedia.org/wiki/Douglas_Adams"
                                                                            }
                                                                          })
    end

    it "allows custom sitelinks response" do
      stub_get_item_sitelinks(item_id, { "dewiki" => { "title" => "Douglas Adams", "badges" => [], "url" => "https://de.wikipedia.org/wiki/Douglas_Adams" } })
      expect(api_client.get_item_sitelinks(item_id).parsed_content).to eq({
                                                                            "dewiki" => { "title" => "Douglas Adams", "badges" => [], "url" => "https://de.wikipedia.org/wiki/Douglas_Adams" }
                                                                          })
    end
  end

  describe "#get_item_sitelink" do
    let(:site_id) { "enwiki" }

    it "gets a specific sitelink by item_id and site_id" do
      stub_get_item_sitelink(item_id, site_id)
      expect(api_client.get_item_sitelink(item_id, site_id).parsed_content).to eq({
                                                                                    "title" => "Douglas Adams",
                                                                                    "badges" => [],
                                                                                    "url" => "https://en.wikipedia.org/wiki/Douglas_Adams"
                                                                                  })
    end

    it "allows custom sitelink response" do
      stub_get_item_sitelink(item_id, site_id, { "title" => "Douglas Adams", "badges" => [], "url" => "https://en.wikipedia.org/wiki/Douglas_Adams" })
      expect(api_client.get_item_sitelink(item_id, site_id).parsed_content).to eq({
                                                                                    "title" => "Douglas Adams",
                                                                                    "badges" => [],
                                                                                    "url" => "https://en.wikipedia.org/wiki/Douglas_Adams"
                                                                                  })
    end
  end

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
