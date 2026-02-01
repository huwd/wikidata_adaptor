# frozen_string_literal: true

require "wikidata_adaptor/rest_api"
require "wikidata_adaptor/test_helpers/rest_api"
require "spec_helper"

RSpec.describe WikidataAdaptor::RestApi::Labels do
  include WikidataAdaptor::TestHelpers::RestApi

  let(:endpoint) { "https://test.test/w/rest.php/wikibase" }
  let(:api_client) { WikidataAdaptor::RestApi.new(endpoint) }
  let(:item_id) { "Q42" }
  let(:property_id) { "P31" }

  describe "#get_item_labels" do
    it "gets item labels in all locales by item_id" do
      stub_get_item_labels(item_id)
      expect(api_client.get_item_labels(item_id).parsed_content)
        .to eq({
                 "en" => "Douglas Adams",
                 "fr" => "Douglas Adams"
               })
    end
  end

  describe "#get_item_label" do
    it "gets an item label by item_id in a specific locale" do
      stub_get_item_label(item_id, "en")
      expect(api_client.get_item_label(item_id, "en").raw_response_body)
        .to eq("Douglas Adams")
    end
  end

  describe "#get_item_label_with_language_fallback" do
    context "when the label is defined in the requested language" do
      it "returns 200 with the label" do
        stub_get_item_label_with_language_fallback(item_id, "en")
        expect(api_client.get_item_label_with_language_fallback(item_id, "en").raw_response_body)
          .to eq("Douglas Adams")
      end
    end

    context "when the label exists only in a fallback language" do
      it "follows the 307 Location redirect" do
        stub_get_item_label_with_language_fallback_redirect(item_id, "en")
        expect(api_client.get_item_label_with_language_fallback(item_id, "en").raw_response_body)
          .to eq("Douglas Adams")
      end
    end
  end

  describe "#get_property_labels" do
    it "gets property labels in all locales by property_id" do
      stub_get_property_labels(property_id)
      expect(api_client.get_property_labels(property_id).parsed_content).to eq({
                                                                                 "en" => "instance of",
                                                                                 "fr" => "est un(e)"
                                                                               })
    end
  end

  describe "#get_property_label" do
    it "gets a property label by property_id in a specific locale" do
      stub_get_property_label(property_id, "en")
      expect(api_client.get_property_label(property_id, "en").raw_response_body).to eq("instance of")
    end
  end

  describe "#get_property_label_with_language_fallback" do
    context "when the label is defined in the requested language" do
      it "returns 200 with the label" do
        stub_get_property_label_with_language_fallback(property_id, "en")
        expect(api_client.get_property_label_with_language_fallback(property_id, "en").raw_response_body)
          .to eq("instance of")
      end
    end

    context "when the label exists only in a fallback language" do
      it "follows the 307 Location redirect" do
        stub_get_property_label_with_language_fallback_redirect(property_id, "en")
        expect(api_client.get_property_label_with_language_fallback(property_id, "en").raw_response_body)
          .to eq("instance of")
      end
    end
  end
end
