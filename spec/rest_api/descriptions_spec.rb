# frozen_string_literal: true

require "wikidata_adaptor/rest_api"
require "wikidata_adaptor/test_helpers/rest_api"
require "spec_helper"

RSpec.describe WikidataAdaptor::RestApi::Descriptions do
  include WikidataAdaptor::TestHelpers::RestApi

  let(:endpoint) { "https://test.test/w/rest.php/wikibase/v0" }
  let(:api_client) { WikidataAdaptor::RestApi.new(endpoint) }
  let(:item_id) { "Q42" }
  let(:property_id) { "P31" }

  describe "#get_item_descriptions" do
    it "gets item descriptions in all locales by item_id" do
      stub_get_item_descriptions(item_id)
      expect(api_client.get_item_descriptions(item_id).parsed_content)
        .to eq({
                 "en" => "English science fiction writer and humourist",
                 "fr" => "écrivain de science-fiction et humoriste anglais"
               })
    end
  end

  describe "#get_item_description" do
    it "gets an item description by item_id in a specific locale" do
      stub_get_item_description(item_id, "en")
      expect(api_client.get_item_description(item_id, "en").raw_response_body)
        .to eq(
          "English science fiction writer and humourist"
        )
    end
  end

  describe "#get_property_descriptions" do
    it "gets property descriptions in all locales by property_id" do
      stub_get_property_descriptions(property_id)
      expect(api_client.get_property_descriptions(property_id).parsed_content)
        .to eq({
                 "en" => "that class of which this subject is a particular example and member",
                 "fr" => "classe dont ce sujet est un exemple particulier"
               })
    end
  end

  describe "#get_property_description" do
    it "gets a property description by property_id in a specific locale" do
      stub_get_property_description(property_id, "en")
      expect(api_client.get_property_description(property_id, "en").raw_response_body)
        .to eq(
          "that class of which this subject is a particular example and member"
        )
    end
  end
end
