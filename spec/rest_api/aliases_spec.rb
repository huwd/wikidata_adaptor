# frozen_string_literal: true

require "wikidata_adaptor/rest_api"
require "wikidata_adaptor/test_helpers/rest_api"
require "spec_helper"

RSpec.describe WikidataAdaptor::RestApi::Aliases do
  include WikidataAdaptor::TestHelpers::RestApi

  let(:endpoint) { "https://test.test/w/rest.php/wikibase" }
  let(:api_client) { WikidataAdaptor::RestApi.new(endpoint) }
  let(:item_id) { "Q42" }
  let(:property_id) { "P31" }

  describe "#get_item_aliases" do
    it "gets item aliases in all locales by item_id" do
      stub_get_item_aliases(item_id)
      expect(api_client.get_item_aliases(item_id).parsed_content)
        .to eq({
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
    it "gets an item's aliases in a specific locale" do
      stub_get_item_alias(item_id, "en")
      expect(api_client.get_item_alias(item_id, "en").parsed_content)
        .to eq([
                 "Douglas Noel Adams",
                 "Douglas Noël Adams"
               ])
    end
  end

  describe "#get_property_aliases" do
    it "gets property aliases in all locales by property_id" do
      stub_get_property_aliases(property_id)
      expect(api_client.get_property_aliases(property_id).parsed_content)
        .to eq({
                 "en" => ["is a"],
                 "fr" => ["est un"]
               })
    end
  end

  describe "#get_property_alias" do
    it "gets property aliases in a specific locale" do
      stub_get_property_alias(property_id, "en")
      expect(api_client.get_property_alias(property_id, "en").parsed_content)
        .to eq(["is a"])
    end
  end
end
