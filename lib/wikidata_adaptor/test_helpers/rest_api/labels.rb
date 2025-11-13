# frozen_string_literal: true

module WikidataAdaptor
  module TestHelpers
    module RestApi
      module Labels
        #####################################
        # GET /v1/entities/items/:item_id/labels
        #####################################
        def stub_get_item_labels(item_id)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/labels",
            response_body: {
              en: "Douglas Adams",
              fr: "Douglas Adams"
            }
          )
        end

        ####################################################
        # GET /v1/entities/items/:item_id/labels/:language_code
        ####################################################
        def stub_get_item_label(item_id, language_code)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/labels/#{language_code}",
            response_body: "Douglas Adams"
          )
        end

        ###########################################
        # GET /v1/entities/properties/:property_id/labels
        ###########################################
        def stub_get_property_labels(property_id)
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}/labels",
            response_body: {
              en: "instance of",
              fr: "est un(e)"
            }
          )
        end

        ########################################################
        # GET /v1/entities/properties/:property_id/labels/:language_code
        ########################################################
        def stub_get_property_label(property_id, language_code)
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}/labels/#{language_code}",
            response_body: "instance of"
          )
        end
      end
    end
  end
end
