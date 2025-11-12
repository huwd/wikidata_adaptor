# frozen_string_literal: true

require "wikidata_adaptor/rest_api"
require "wikidata_adaptor/test_helpers/rest_api"
require "spec_helper"

RSpec.describe WikidataAdaptor::RestApi::Statements do
  include WikidataAdaptor::TestHelpers::RestApi

  let(:endpoint) { "https://test.test/w/rest.php/wikibase/v0" }
  let(:api_client) { WikidataAdaptor::RestApi.new(endpoint) }
  let(:item_id) { "Q42" }
  let(:property_id) { "P31" }
  let(:statement_id) { "Q42$F078E5B3-F9A8-480E-B7AC-D97778CBBEF9" }

  describe "#get_item_statements" do
    it "gets all the statements related to an item identified by item_id" do
      stub_get_item_statements(item_id)
      expect(api_client.get_item_statements(item_id).parsed_content.keys)
        .to eq(
          %w[additionalProp1]
        )
    end

    it "has a test helper that allows you to submit your own response to test" do
      stub_get_item_statements(item_id, { "foo" => "bar" })
      expect(api_client.get_item_statements(item_id).parsed_content)
        .to eq({
                 "foo" => "bar"
               })
    end
  end

  describe "#get_item_statement" do
    it "returns a specific statement by item_id and statement_id" do
      stub_get_item_statement(item_id, statement_id)
      expect(api_client.get_item_statement(item_id, statement_id).parsed_content)
        .to eq({
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
    it "returns a specific statement by statement_id" do
      stub_get_statement(statement_id)
      expect(api_client.get_statement(statement_id).parsed_content)
        .to eq({
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

  describe "#get_property_statements" do
    it "gets all the statements related to a property identified by property_id" do
      stub_get_property_statements(property_id, { "P31" => [] })
      expect(api_client.get_property_statements(property_id).parsed_content)
        .to eq({ "P31" => [] })
    end
  end

  describe "#get_property_statement" do
    let(:property_statement_id) { "P31$11111111-2222-3333-4444-555555555555" }

    it "returns a specific statement by property_id and statement_id" do
      stub_get_property_statement(property_id, property_statement_id)
      expect(api_client.get_property_statement(property_id, property_statement_id).parsed_content)
        .to eq({
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
