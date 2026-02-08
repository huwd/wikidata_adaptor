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
  end
end
