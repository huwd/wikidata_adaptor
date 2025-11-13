# frozen_string_literal: true

require "wikidata_adaptor/rest_api"
require "wikidata_adaptor/test_helpers/rest_api"
require "spec_helper"

RSpec.describe WikidataAdaptor::RestApi::PropertyDataTypes do
  include WikidataAdaptor::TestHelpers::RestApi

  let(:endpoint) { "https://test.test/w/rest.php/wikibase" }
  let(:api_client) { WikidataAdaptor::RestApi.new(endpoint) }

  describe "#get_property_data_types" do
    it "Retrieve the map of Property data types to value types" do
      stub_get_property_data_types
      expect(api_client.get_property_data_types.parsed_content).to include(
        "data-type" => "value-type"
      )
    end
  end
end
