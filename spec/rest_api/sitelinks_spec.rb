# frozen_string_literal: true

require "wikidata_adaptor/rest_api"
require "wikidata_adaptor/test_helpers/rest_api"
require "spec_helper"

RSpec.describe WikidataAdaptor::RestApi::Sitelinks do
  include WikidataAdaptor::TestHelpers::RestApi

  let(:endpoint) { "https://test.test/w/rest.php/wikibase/v0" }
  let(:api_client) { WikidataAdaptor::RestApi.new(endpoint) }
  let(:item_id) { "Q42" }

  describe "#get_item_sitelinks" do
    it "gets item sitelinks by item_id" do
      stub_get_item_sitelinks(item_id)
      expect(api_client.get_item_sitelinks(item_id).parsed_content)
        .to eq({
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
      expect(api_client.get_item_sitelinks(item_id).parsed_content)
        .to eq({
                 "dewiki" => { "title" => "Douglas Adams", "badges" => [], "url" => "https://de.wikipedia.org/wiki/Douglas_Adams" }
               })
    end
  end

  describe "#get_item_sitelink" do
    let(:site_id) { "enwiki" }

    it "gets a specific sitelink by item_id and site_id" do
      stub_get_item_sitelink(item_id, site_id)
      expect(api_client.get_item_sitelink(item_id, site_id).parsed_content)
        .to eq({
                 "title" => "Douglas Adams",
                 "badges" => [],
                 "url" => "https://en.wikipedia.org/wiki/Douglas_Adams"
               })
    end

    it "allows custom sitelink response" do
      stub_get_item_sitelink(item_id, site_id, { "title" => "Douglas Adams", "badges" => [], "url" => "https://en.wikipedia.org/wiki/Douglas_Adams" })
      expect(api_client.get_item_sitelink(item_id, site_id).parsed_content)
        .to eq({
                 "title" => "Douglas Adams",
                 "badges" => [],
                 "url" => "https://en.wikipedia.org/wiki/Douglas_Adams"
               })
    end
  end
end
