# frozen_string_literal: true

require_relative "integration_helper"

RSpec.describe "Sitelinks", :integration do
  include WikidataAdaptor::Integration::Helpers

  before(:context) do
    extend WikidataAdaptor::Integration::Helpers

    @item = create_item!(labels: { "en" => "Sitelinks item #{SecureRandom.hex(4)}" })
  end

  describe "#get_item_sitelinks" do
    it "returns a hash (empty when no sites are configured)" do
      result = api_client.get_item_sitelinks(@item["id"]).parsed_content

      expect(result).to be_a(Hash)
    end
  end

  describe "#put_item_sitelink" do
    it "is not testable without configured sites in Docker Wikibase" do
      skip "Docker Wikibase does not have sites configured for put_item_sitelink testing"
    end
  end

  describe "#patch_item_sitelinks" do
    it "is not testable without configured sites in Docker Wikibase" do
      skip "Docker Wikibase does not have sites configured for patch_item_sitelinks testing"
    end
  end
end
