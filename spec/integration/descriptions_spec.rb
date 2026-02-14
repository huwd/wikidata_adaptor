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

    describe "#put_property_description" do
      it "replaces a property description and returns the new value" do
        new_desc = "Updated prop desc #{SecureRandom.hex(4)}"
        payload = { "description" => new_desc, "comment" => "integration test" }
        put_response = api_client.put_property_description(@property["id"], "en", payload)

        expect(put_response.parsed_content).to eq(new_desc)

        fetched = wait_for_consistency(put_response) do
          api_client.get_property_description(@property["id"], "en")
        end
        expect(fetched).to eq(new_desc)
      end
    end
  end

  describe "put item descriptions" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @en_desc = "Desc to replace #{SecureRandom.hex(4)}"
      @item = create_item!(
        labels: { "en" => "Put desc item #{SecureRandom.hex(4)}" },
        descriptions: { "en" => @en_desc }
      )
    end

    describe "#put_item_description" do
      it "replaces an item description and returns the new value" do
        new_desc = "Updated item desc #{SecureRandom.hex(4)}"
        payload = { "description" => new_desc, "comment" => "integration test" }
        put_response = api_client.put_item_description(@item["id"], "en", payload)

        expect(put_response.parsed_content).to eq(new_desc)

        fetched = wait_for_consistency(put_response) do
          api_client.get_item_description(@item["id"], "en")
        end
        expect(fetched).to eq(new_desc)
      end
    end

    describe "#patch_item_descriptions" do
      it "patches item descriptions and returns the updated descriptions" do
        new_desc = "Patched desc #{SecureRandom.hex(4)}"
        payload = {
          "patch" => [{ "op" => "replace", "path" => "/en", "value" => new_desc }],
          "comment" => "integration test"
        }
        result = api_client.patch_item_descriptions(@item["id"], payload).parsed_content

        expect(result["en"]).to eq(new_desc)
      end
    end
  end

  describe "patch property descriptions" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @property = create_property!(
        labels: { "en" => "Patch desc prop #{SecureRandom.hex(4)}" },
        descriptions: { "en" => "Desc to patch #{SecureRandom.hex(4)}" }
      )
    end

    describe "#patch_property_descriptions" do
      it "patches property descriptions and returns the updated descriptions" do
        new_desc = "Patched prop desc #{SecureRandom.hex(4)}"
        payload = {
          "patch" => [{ "op" => "replace", "path" => "/en", "value" => new_desc }],
          "comment" => "integration test"
        }
        result = api_client.patch_property_descriptions(@property["id"], payload).parsed_content

        expect(result["en"]).to eq(new_desc)
      end
    end
  end

  describe "delete item descriptions" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @item = create_item!(
        labels: { "en" => "Delete desc #{SecureRandom.hex(4)}" },
        descriptions: { "en" => "Desc to delete #{SecureRandom.hex(4)}", "fr" => "Desc fr #{SecureRandom.hex(4)}" }
      )
    end

    describe "#delete_item_description" do
      it "deletes an item description and confirms deletion" do
        payload = { "comment" => "integration test delete" }
        delete_response = api_client.delete_item_description(@item["id"], "en", payload)

        expect(delete_response.raw_response_body).to eq("Description deleted")

        wait_for_consistency(delete_response) do
          result = api_client.get_item_descriptions(@item["id"]).parsed_content
          result["en"].nil?
        end

        final_descriptions = api_client.get_item_descriptions(@item["id"]).parsed_content
        expect(final_descriptions).not_to have_key("en")
        expect(final_descriptions).to have_key("fr")
      end
    end
  end

  describe "delete property descriptions" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @property = create_property!(
        labels: { "en" => "Delete prop desc #{SecureRandom.hex(4)}" },
        descriptions: { "en" => "Prop desc to delete #{SecureRandom.hex(4)}", "fr" => "Prop desc fr #{SecureRandom.hex(4)}" }
      )
    end

    describe "#delete_property_description" do
      it "deletes a property description and confirms deletion" do
        payload = { "comment" => "integration test delete" }
        delete_response = api_client.delete_property_description(@property["id"], "en", payload)

        expect(delete_response.raw_response_body).to eq("Description deleted")

        wait_for_consistency(delete_response) do
          result = api_client.get_property_descriptions(@property["id"]).parsed_content
          result["en"].nil?
        end

        final_descriptions = api_client.get_property_descriptions(@property["id"]).parsed_content
        expect(final_descriptions).not_to have_key("en")
        expect(final_descriptions).to have_key("fr")
      end
    end
  end
end
