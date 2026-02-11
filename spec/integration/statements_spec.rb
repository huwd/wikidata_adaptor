# frozen_string_literal: true

require_relative "integration_helper"

RSpec.describe "Statements", :integration do
  include WikidataAdaptor::Integration::Helpers

  describe "item statements" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @item = create_item!(labels: { "en" => "Stmts item #{SecureRandom.hex(4)}" })
      @string_property = create_property!(
        data_type: "string",
        labels: { "en" => "Stmts string prop #{SecureRandom.hex(4)}" }
      )
    end

    describe "#get_item_statements" do
      it "returns a hash of statements (empty for a new item)" do
        result = api_client.get_item_statements(@item["id"]).parsed_content

        expect(result).to be_a(Hash)
        expect(result).to be_empty
      end
    end

    describe "#post_item_statement" do
      it "creates a statement on an item and returns it" do
        payload = {
          "statement" => {
            "property" => { "id" => @string_property["id"] },
            "value" => { "type" => "value", "content" => "test value" }
          },
          "comment" => "integration test"
        }
        result = api_client.post_item_statement(@item["id"], payload).parsed_content

        expect(result["id"]).to match(/\A#{@item["id"]}\$/)
        expect(result["rank"]).to eq("normal")
        expect(result["property"]["id"]).to eq(@string_property["id"])
        expect(result["value"]["content"]).to eq("test value")
      end
    end
  end

  describe "property statements" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @property = create_property!(labels: { "en" => "Stmts prop #{SecureRandom.hex(4)}" })
      @string_property = create_property!(
        data_type: "string",
        labels: { "en" => "Stmts string prop 2 #{SecureRandom.hex(4)}" }
      )
    end

    describe "#get_property_statements" do
      it "returns a hash of statements (empty for a new property)" do
        result = api_client.get_property_statements(@property["id"]).parsed_content

        expect(result).to be_a(Hash)
        expect(result).to be_empty
      end
    end

    describe "#post_property_statement" do
      it "creates a statement on a property and returns it" do
        payload = {
          "statement" => {
            "property" => { "id" => @string_property["id"] },
            "value" => { "type" => "value", "content" => "test value" }
          },
          "comment" => "integration test"
        }
        result = api_client.post_property_statement(@property["id"], payload).parsed_content

        expect(result["id"]).to match(/\A#{@property["id"]}\$/)
        expect(result["rank"]).to eq("normal")
        expect(result["property"]["id"]).to eq(@string_property["id"])
        expect(result["value"]["content"]).to eq("test value")
      end
    end
  end
end
