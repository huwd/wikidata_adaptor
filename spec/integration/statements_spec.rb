# frozen_string_literal: true

require_relative "integration_helper"

RSpec.describe "Statements", :integration do
  include WikidataAdaptor::Integration::Helpers

  describe "item statements" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @item = create_item!(labels: { "en" => "Stmts item #{SecureRandom.hex(4)}" })
    end

    describe "#get_item_statements" do
      it "returns a hash of statements (empty for a new item)" do
        result = api_client.get_item_statements(@item["id"]).parsed_content

        expect(result).to be_a(Hash)
        expect(result).to be_empty
      end
    end
  end

  describe "property statements" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @property = create_property!(labels: { "en" => "Stmts prop #{SecureRandom.hex(4)}" })
    end

    describe "#get_property_statements" do
      it "returns a hash of statements (empty for a new property)" do
        result = api_client.get_property_statements(@property["id"]).parsed_content

        expect(result).to be_a(Hash)
        expect(result).to be_empty
      end
    end
  end
end
