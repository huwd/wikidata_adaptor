# frozen_string_literal: true

module WikidataAdaptor
  module TestHelpers
    module RestApi
      # https://doc.wikimedia.org/Wikibase/master/js/rest-api/#/Property%20data%20types/getPropertyDataTypes
      module PropertyDataTypes
        ##########################################
        # GET /v1/property-data-types
        ##########################################
        def stub_get_property_data_types
          stub_rest_api_request(
            :get,
            "/v1/property-data-types",
            response_body: {
              "data-type" => "value-type"
            }
          )
        end
      end
    end
  end
end
