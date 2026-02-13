# frozen_string_literal: true

require_relative "integration_helper"

RSpec.describe "Properties", :integration do
  include WikidataAdaptor::Integration::Helpers

  describe "#get_property" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @label = "Props integ #{SecureRandom.hex(4)}"
      @property = create_property!(
        labels: { "en" => @label },
        descriptions: { "en" => "A property for integration testing #{SecureRandom.hex(4)}" }
      )
    end

    it "retrieves a property with expected keys" do
      result = api_client.get_property(@property["id"]).parsed_content

      expect(result.keys).to include("id", "type", "labels", "descriptions", "aliases", "statements")
      expect(result["id"]).to eq(@property["id"])
      expect(result["type"]).to eq("property")
      expect(result["labels"]).to include("en" => @label)
    end

    it "raises 400 for an invalid property ID" do
      expect { api_client.get_property("not-valid") }.to raise_error(ApiAdaptor::HTTPBadRequest)
    end

    it "raises 404 for a property that does not exist" do
      expect { api_client.get_property("P99999999") }.to raise_error(ApiAdaptor::HTTPNotFound)
    end
  end

  describe "#post_property" do
    it "creates a new property and returns it" do
      label = "Post prop #{SecureRandom.hex(4)}"
      desc = "Created by integration #{SecureRandom.hex(4)}"
      payload = {
        "property" => {
          "data_type" => "string",
          "labels" => { "en" => label },
          "descriptions" => { "en" => desc }
        },
        "comment" => "integration test"
      }
      result = api_client.post_property(payload).parsed_content

      expect(result["id"]).to match(/\AP\d+\z/)
      expect(result["type"]).to eq("property")
      expect(result["data_type"]).to eq("string")
      expect(result["labels"]).to include("en" => label)
      expect(result["descriptions"]).to include("en" => desc)
    end
  end

  describe "#patch_property" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @property = create_property!(labels: { "en" => "Patch prop #{SecureRandom.hex(4)}" })
    end

    it "patches a property and returns the updated property" do
      new_label = "Patched prop #{SecureRandom.hex(4)}"
      payload = {
        "patch" => [{ "op" => "replace", "path" => "/labels/en", "value" => new_label }],
        "comment" => "integration test"
      }
      result = api_client.patch_property(@property["id"], payload).parsed_content

      expect(result["id"]).to eq(@property["id"])
      expect(result["labels"]["en"]).to eq(new_label)
    end
  end
end
