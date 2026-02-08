# frozen_string_literal: true

require_relative "integration_helper"

RSpec.describe "Descriptions", :integration do
  include WikidataAdaptor::Integration::Helpers

  describe "item descriptions" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @en_desc = "English desc #{SecureRandom.hex(4)}"
      @fr_desc = "French desc #{SecureRandom.hex(4)}"
      @item = create_item!(
        labels: { "en" => "Desc item #{SecureRandom.hex(4)}" },
        descriptions: { "en" => @en_desc, "fr" => @fr_desc }
      )
    end

    describe "#get_item_descriptions" do
      it "returns descriptions keyed by language" do
        result = api_client.get_item_descriptions(@item["id"]).parsed_content

        expect(result).to include("en" => @en_desc, "fr" => @fr_desc)
      end
    end

    describe "#get_item_description" do
      it "returns a single description for the requested language" do
        result = api_client.get_item_description(@item["id"], "en").parsed_content

        expect(result).to eq(@en_desc)
      end
    end
  end

  describe "property descriptions" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @en_desc = "Prop English desc #{SecureRandom.hex(4)}"
      @fr_desc = "Prop French desc #{SecureRandom.hex(4)}"
      @property = create_property!(
        labels: { "en" => "Desc prop #{SecureRandom.hex(4)}" },
        descriptions: { "en" => @en_desc, "fr" => @fr_desc }
      )
    end

    describe "#get_property_descriptions" do
      it "returns descriptions keyed by language" do
        result = api_client.get_property_descriptions(@property["id"]).parsed_content

        expect(result).to include("en" => @en_desc, "fr" => @fr_desc)
      end
    end

    describe "#get_property_description" do
      it "returns a single description for the requested language" do
        result = api_client.get_property_description(@property["id"], "en").parsed_content

        expect(result).to eq(@en_desc)
      end
    end
  end
end
