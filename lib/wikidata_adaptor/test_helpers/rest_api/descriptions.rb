# frozen_string_literal: true

module WikidataAdaptor
  module TestHelpers
    module RestApi
      module Descriptions
        ###########################################
        # GET /v1/entities/items/:item_id/descriptions
        ###########################################
        def stub_get_item_descriptions(item_id)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/descriptions",
            response_body: {
              en: "English science fiction writer and humourist",
              fr: "écrivain de science-fiction et humoriste anglais"
            }
          )
        end

        ##########################################################
        # GET /v1/entities/items/:item_id/descriptions/:language_code
        ##########################################################
        def stub_get_item_description(item_id, language_code)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/descriptions/#{language_code}",
            response_body: "English science fiction writer and humourist"
          )
        end

        ##############################################
        # GET /v1/entities/properties/:property_id/descriptions
        ##############################################
        def stub_get_property_descriptions(property_id)
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}/descriptions",
            response_body: {
              en: "that class of which this subject is a particular example and member",
              fr: "classe dont ce sujet est un exemple particulier"
            }
          )
        end

        ################################################################
        # GET /v1/entities/properties/:property_id/descriptions/:language_code
        ################################################################
        def stub_get_property_description(property_id, language_code)
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}/descriptions/#{language_code}",
            response_body: "that class of which this subject is a particular example and member"
          )
        end
      end
    end
  end
end
