# frozen_string_literal: true

require_relative "integration_helper"

RSpec.describe "Aliases", :integration do
  include WikidataAdaptor::Integration::Helpers

  describe "item aliases" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @alias_a = "Alias A #{SecureRandom.hex(4)}"
      @alias_b = "Alias B #{SecureRandom.hex(4)}"
      @alias_fr = "Alias F #{SecureRandom.hex(4)}"
      @item = create_item!(
        labels: { "en" => "Alias item #{SecureRandom.hex(4)}" },
        aliases: { "en" => [@alias_a, @alias_b], "fr" => [@alias_fr] }
      )
    end

    describe "#get_item_aliases" do
      it "returns aliases keyed by language" do
        result = api_client.get_item_aliases(@item["id"]).parsed_content

        expect(result).to include(
          "en" => [@alias_a, @alias_b],
          "fr" => [@alias_fr]
        )
      end
    end

    describe "#get_item_alias" do
      it "returns aliases for a specific language" do
        result = api_client.get_item_alias(@item["id"], "en").parsed_content

        expect(result).to eq([@alias_a, @alias_b])
      end
    end

    describe "#post_item_aliases" do
      it "adds aliases and returns the updated list" do
        new_alias = "New alias #{SecureRandom.hex(4)}"
        payload = { "aliases" => [new_alias], "comment" => "integration test" }
        result = api_client.post_item_aliases(@item["id"], "en", payload).parsed_content

        expect(result).to include(new_alias)
      end
    end
  end

  describe "property aliases" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @prop_alias_en = "Prop alias #{SecureRandom.hex(4)}"
      @prop_alias_fr = "Prop alias fr #{SecureRandom.hex(4)}"
      @property = create_property!(
        labels: { "en" => "Alias prop #{SecureRandom.hex(4)}" },
        aliases: { "en" => [@prop_alias_en], "fr" => [@prop_alias_fr] }
      )
    end

    describe "#get_property_aliases" do
      it "returns aliases keyed by language" do
        result = api_client.get_property_aliases(@property["id"]).parsed_content

        expect(result).to include(
          "en" => [@prop_alias_en],
          "fr" => [@prop_alias_fr]
        )
      end
    end

    describe "#get_property_alias" do
      it "returns aliases for a specific language" do
        result = api_client.get_property_alias(@property["id"], "en").parsed_content

        expect(result).to eq([@prop_alias_en])
      end
    end

    describe "#post_property_aliases" do
      it "adds aliases and returns the updated list" do
        new_alias = "Prop new alias #{SecureRandom.hex(4)}"
        payload = { "aliases" => [new_alias], "comment" => "integration test" }
        result = api_client.post_property_aliases(@property["id"], "en", payload).parsed_content

        expect(result).to include(new_alias)
      end
    end
  end
end
