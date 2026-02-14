# frozen_string_literal: true

require_relative "integration_helper"

RSpec.describe "Labels", :integration do
  include WikidataAdaptor::Integration::Helpers

  describe "item labels" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @en_label = "Label item en #{SecureRandom.hex(4)}"
      @fr_label = "Label item fr #{SecureRandom.hex(4)}"
      @item = create_item!(labels: { "en" => @en_label, "fr" => @fr_label })
    end

    describe "#get_item_labels" do
      it "returns labels keyed by language" do
        result = api_client.get_item_labels(@item["id"]).parsed_content

        expect(result).to include("en" => @en_label, "fr" => @fr_label)
      end
    end

    describe "#get_item_label" do
      it "returns a single label for the requested language" do
        result = api_client.get_item_label(@item["id"], "en").parsed_content

        expect(result).to eq(@en_label)
      end
    end

    describe "#get_item_label_with_language_fallback" do
      it "returns the label when it exists in the requested language" do
        result = api_client.get_item_label_with_language_fallback(@item["id"], "en").parsed_content

        expect(result).to eq(@en_label)
      end

      it "falls back when the requested language is not defined" do
        result = api_client.get_item_label_with_language_fallback(@item["id"], "en-gb").parsed_content

        expect(result).to eq(@en_label)
      end
    end
  end

  describe "property labels" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @en_label = "Label prop en #{SecureRandom.hex(4)}"
      @fr_label = "Label prop fr #{SecureRandom.hex(4)}"
      @property = create_property!(labels: { "en" => @en_label, "fr" => @fr_label })
    end

    describe "#get_property_labels" do
      it "returns labels keyed by language" do
        result = api_client.get_property_labels(@property["id"]).parsed_content

        expect(result).to include("en" => @en_label, "fr" => @fr_label)
      end
    end

    describe "#get_property_label" do
      it "returns a single label for the requested language" do
        result = api_client.get_property_label(@property["id"], "en").parsed_content

        expect(result).to eq(@en_label)
      end
    end

    describe "#get_property_label_with_language_fallback" do
      it "returns the label when it exists in the requested language" do
        result = api_client.get_property_label_with_language_fallback(@property["id"], "en").parsed_content

        expect(result).to eq(@en_label)
      end

      it "falls back when the requested language is not defined" do
        result = api_client.get_property_label_with_language_fallback(@property["id"], "en-gb").parsed_content

        expect(result).to eq(@en_label)
      end
    end

    describe "#put_property_label" do
      it "replaces a property label and returns the new value" do
        new_label = "Updated prop label #{SecureRandom.hex(4)}"
        payload = { "label" => new_label, "comment" => "integration test" }
        put_response = api_client.put_property_label(@property["id"], "en", payload)

        expect(put_response.parsed_content).to eq(new_label)

        fetched = wait_for_consistency(put_response) do
          api_client.get_property_label(@property["id"], "en")
        end
        expect(fetched).to eq(new_label)
      end
    end
  end

  describe "put item labels" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @item = create_item!(labels: { "en" => "Put label item #{SecureRandom.hex(4)}" })
    end

    describe "#put_item_label" do
      it "replaces an item label and returns the new value" do
        new_label = "Updated item label #{SecureRandom.hex(4)}"
        payload = { "label" => new_label, "comment" => "integration test" }
        put_response = api_client.put_item_label(@item["id"], "en", payload)

        expect(put_response.parsed_content).to eq(new_label)

        fetched = wait_for_consistency(put_response) do
          api_client.get_item_label(@item["id"], "en")
        end
        expect(fetched).to eq(new_label)
      end
    end

    describe "#patch_item_labels" do
      it "patches item labels and returns the updated labels" do
        new_label = "Patched label #{SecureRandom.hex(4)}"
        payload = {
          "patch" => [{ "op" => "replace", "path" => "/en", "value" => new_label }],
          "comment" => "integration test"
        }
        result = api_client.patch_item_labels(@item["id"], payload).parsed_content

        expect(result["en"]).to eq(new_label)
      end
    end
  end

  describe "patch property labels" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @property = create_property!(labels: { "en" => "Patch lbl prop #{SecureRandom.hex(4)}" })
    end

    describe "#patch_property_labels" do
      it "patches property labels and returns the updated labels" do
        new_label = "Patched prop label #{SecureRandom.hex(4)}"
        payload = {
          "patch" => [{ "op" => "replace", "path" => "/en", "value" => new_label }],
          "comment" => "integration test"
        }
        result = api_client.patch_property_labels(@property["id"], payload).parsed_content

        expect(result["en"]).to eq(new_label)
      end
    end
  end
end
