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

  describe "#post_item_aliases" do
    let(:payload) { { "aliases" => ["Douglas Noel Adams"], "comment" => "Add alias" } }

    it "adds aliases to an item and returns the updated list" do
      stub_post_item_aliases(item_id, "en", payload)
      expect(api_client.post_item_aliases(item_id, "en", payload).parsed_content)
        .to eq(["Douglas Noel Adams", "Douglas Noël Adams"])
    end

    it "raises a 500 response status if there's an unexpected error" do
      stub_post_item_aliases_unexpected_error(item_id, "en", payload)
      expect { api_client.post_item_aliases(item_id, "en", payload) }.to raise_error(ApiAdaptor::HTTPInternalServerError)
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

  describe "#post_property_aliases" do
    let(:payload) { { "aliases" => ["is an"], "comment" => "Add alias" } }

    it "adds aliases to a property and returns the updated list" do
      stub_post_property_aliases(property_id, "en", payload)
      expect(api_client.post_property_aliases(property_id, "en", payload).parsed_content)
        .to eq(["is a", "is an"])
    end

    it "raises a 500 response status if there's an unexpected error" do
      stub_post_property_aliases_unexpected_error(property_id, "en", payload)
      expect { api_client.post_property_aliases(property_id, "en", payload) }.to raise_error(ApiAdaptor::HTTPInternalServerError)
    end
  end

  describe "#patch_item_aliases" do
    let(:payload) do
      {
        "patch" => [{ "op" => "add", "path" => "/en/-", "value" => "DNA" }],
        "comment" => "Patch aliases"
      }
    end

    it "patches item aliases and returns the updated aliases" do
      stub_patch_item_aliases(item_id, payload)
      expect(api_client.patch_item_aliases(item_id, payload).parsed_content)
        .to include("en" => ["Douglas Noel Adams", "Douglas Noël Adams", "DNA"])
    end

    it "raises a 500 response status if there's an unexpected error" do
      stub_patch_item_aliases_unexpected_error(item_id, payload)
      expect { api_client.patch_item_aliases(item_id, payload) }
        .to raise_error(ApiAdaptor::HTTPInternalServerError)
    end
  end

  describe "#patch_property_aliases" do
    let(:payload) do
      {
        "patch" => [{ "op" => "add", "path" => "/en/-", "value" => "is an" }],
        "comment" => "Patch aliases"
      }
    end

    it "patches property aliases and returns the updated aliases" do
      stub_patch_property_aliases(property_id, payload)
      expect(api_client.patch_property_aliases(property_id, payload).parsed_content)
        .to include("en" => ["is a", "is an"])
    end

    it "raises a 500 response status if there's an unexpected error" do
      stub_patch_property_aliases_unexpected_error(property_id, payload)
      expect { api_client.patch_property_aliases(property_id, payload) }
        .to raise_error(ApiAdaptor::HTTPInternalServerError)
    end
  end
end
