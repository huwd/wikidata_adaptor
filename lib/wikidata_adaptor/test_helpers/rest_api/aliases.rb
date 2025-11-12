# frozen_string_literal: true

module WikidataAdaptor
  module TestHelpers
    module RestApi
      module Aliases
        ######################################
        # GET /entities/items/:item_id/aliases
        ######################################
        def stub_get_item_aliases(item_id)
          stub_rest_api_request(
            :get,
            "/entities/items/#{item_id}/aliases",
            response_body: {
              en: [
                "Douglas Noel Adams",
                "Douglas Noël Adams"
              ],
              fr: [
                "Douglas Noel Adams"
              ]
            }
          )
        end

        #####################################################
        # GET /entities/items/:item_id/aliases/:language_code
        #####################################################
        def stub_get_item_alias(item_id, language_code)
          stub_rest_api_request(
            :get,
            "/entities/items/#{item_id}/aliases/#{language_code}",
            response_body: [
              "Douglas Noel Adams",
              "Douglas Noël Adams"
            ]
          )
        end

        ########################################
        # GET /entities/properties/:property_id/aliases
        ########################################
        def stub_get_property_aliases(property_id)
          stub_rest_api_request(
            :get,
            "/entities/properties/#{property_id}/aliases",
            response_body: {
              en: ["is a"],
              fr: ["est un"]
            }
          )
        end

        ########################################################
        # GET /entities/properties/:property_id/aliases/:language_code
        ########################################################
        def stub_get_property_alias(property_id, language_code)
          stub_rest_api_request(
            :get,
            "/entities/properties/#{property_id}/aliases/#{language_code}",
            response_body: ["is a"]
          )
        end
      end
    end
  end
end
