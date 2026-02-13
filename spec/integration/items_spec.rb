# frozen_string_literal: true

require_relative "integration_helper"

RSpec.describe "Items", :integration do
  include WikidataAdaptor::Integration::Helpers

  describe "#get_item" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @label = "Item get #{SecureRandom.hex(4)}"
      @item = create_item!(labels: { "en" => @label })
    end

    it "retrieves an item with expected keys" do
      result = api_client.get_item(@item["id"]).parsed_content

      expect(result.keys).to include("id", "type", "labels", "descriptions", "aliases", "statements", "sitelinks")
      expect(result["id"]).to eq(@item["id"])
      expect(result["type"]).to eq("item")
      expect(result["labels"]).to include("en" => @label)
    end

    it "raises 400 for an invalid item ID" do
      expect { api_client.get_item("not-a-valid-id") }.to raise_error(ApiAdaptor::HTTPBadRequest)
    end

    it "raises 404 for an item that does not exist" do
      expect { api_client.get_item("Q99999999") }.to raise_error(ApiAdaptor::HTTPNotFound)
    end
  end

  describe "#post_item" do
    it "creates a new item and returns it" do
      label = "Post item #{SecureRandom.hex(4)}"
      desc = "Created by integration #{SecureRandom.hex(4)}"
      result = create_item!(
        labels: { "en" => label },
        descriptions: { "en" => desc }
      )

      expect(result["id"]).to match(/\AQ\d+\z/)
      expect(result["type"]).to eq("item")
      expect(result["labels"]).to include("en" => label)
      expect(result["descriptions"]).to include("en" => desc)
    end
  end

  describe "#patch_item" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @item = create_item!(labels: { "en" => "Patch item #{SecureRandom.hex(4)}" })
    end

    it "patches an item and returns the updated item" do
      new_label = "Patched item #{SecureRandom.hex(4)}"
      payload = {
        "patch" => [{ "op" => "replace", "path" => "/labels/en", "value" => new_label }],
        "comment" => "integration test"
      }
      result = api_client.patch_item(@item["id"], payload).parsed_content

      expect(result["id"]).to eq(@item["id"])
      expect(result["labels"]["en"]).to eq(new_label)
    end
  end
end
