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

        ###############################################################################
        # GET /v1/entities/items/:item_id/descriptions_with_language_fallback/:language_code
        ###############################################################################
        def stub_get_item_description_with_language_fallback(item_id, language_code)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/descriptions_with_language_fallback/#{language_code}",
            response_body: "English science fiction writer and humourist"
          )
        end

        ###############################################################################
        # GET /v1/entities/items/:item_id/descriptions_with_language_fallback/:language_code
        # -> 307 Location: /v1/entities/items/:item_id/descriptions/:redirect_language_code
        ###############################################################################
        def stub_get_item_description_with_language_fallback_redirect(item_id, language_code,
                                                                      redirect_language_code: language_code,
                                                                      response_body: "English science fiction writer and humourist")
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/descriptions_with_language_fallback/#{language_code}",
            response_status: 307,
            response_headers: {
              "Location" => "#{WIKIBASE_REST_ENDPOINT}/v1/entities/items/#{item_id}/descriptions/#{redirect_language_code}"
            },
            response_body: ""
          )

          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/descriptions/#{redirect_language_code}",
            response_body: response_body
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

        #######################################################################################
        # GET /v1/entities/properties/:property_id/descriptions_with_language_fallback/:language_code
        #######################################################################################
        def stub_get_property_description_with_language_fallback(property_id, language_code)
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}/descriptions_with_language_fallback/#{language_code}",
            response_body: "that class of which this subject is a particular example and member"
          )
        end

        #######################################################################################
        # GET /v1/entities/properties/:property_id/descriptions_with_language_fallback/:language_code
        # -> 307 Location: /v1/entities/properties/:property_id/descriptions/:redirect_language_code
        #######################################################################################
        def stub_get_property_description_with_language_fallback_redirect(property_id, language_code,
                                                                          redirect_language_code: language_code,
                                                                          response_body: "that class of which this subject is a particular example and member")
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}/descriptions_with_language_fallback/#{language_code}",
            response_status: 307,
            response_headers: {
              "Location" => "#{WIKIBASE_REST_ENDPOINT}/v1/entities/properties/#{property_id}/descriptions/#{redirect_language_code}"
            },
            response_body: ""
          )

          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}/descriptions/#{redirect_language_code}",
            response_body: response_body
          )
        end

        ################################################################
        # PUT /v1/entities/items/:item_id/descriptions/:language_code
        ################################################################
        def stub_put_item_description(item_id, language_code, payload, response_body: nil)
          stub_rest_api_request(
            :put,
            "/v1/entities/items/#{item_id}/descriptions/#{language_code}",
            with: { body: payload.to_json },
            response_body: response_body || payload["description"]
          )
        end

        def stub_put_item_description_unexpected_error(item_id, language_code, payload)
          stub_rest_api_request(
            :put,
            "/v1/entities/items/#{item_id}/descriptions/#{language_code}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        ######################################################################
        # PUT /v1/entities/properties/:property_id/descriptions/:language_code
        ######################################################################
        def stub_put_property_description(property_id, language_code, payload, response_body: nil)
          stub_rest_api_request(
            :put,
            "/v1/entities/properties/#{property_id}/descriptions/#{language_code}",
            with: { body: payload.to_json },
            response_body: response_body || payload["description"]
          )
        end

        def stub_put_property_description_unexpected_error(property_id, language_code, payload)
          stub_rest_api_request(
            :put,
            "/v1/entities/properties/#{property_id}/descriptions/#{language_code}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        ################################################
        # PATCH /v1/entities/items/:item_id/descriptions
        ################################################
        def stub_patch_item_descriptions(item_id, payload, response_body: nil)
          stub_rest_api_request(
            :patch,
            "/v1/entities/items/#{item_id}/descriptions",
            with: { body: payload.to_json },
            response_body: response_body || {
              en: "British author",
              fr: "écrivain de science-fiction et humoriste anglais"
            }
          )
        end

        def stub_patch_item_descriptions_unexpected_error(item_id, payload)
          stub_rest_api_request(
            :patch,
            "/v1/entities/items/#{item_id}/descriptions",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        ######################################################
        # PATCH /v1/entities/properties/:property_id/descriptions
        ######################################################
        def stub_patch_property_descriptions(property_id, payload, response_body: nil)
          stub_rest_api_request(
            :patch,
            "/v1/entities/properties/#{property_id}/descriptions",
            with: { body: payload.to_json },
            response_body: response_body || {
              en: "class membership",
              fr: "classe dont ce sujet est un exemple particulier"
            }
          )
        end

        def stub_patch_property_descriptions_unexpected_error(property_id, payload)
          stub_rest_api_request(
            :patch,
            "/v1/entities/properties/#{property_id}/descriptions",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        #####################################################################
        # DELETE /v1/entities/items/:item_id/descriptions/:language_code
        #####################################################################
        def stub_delete_item_description(item_id, language_code, payload, response_body: "Description deleted")
          stub_rest_api_request(
            :delete,
            "/v1/entities/items/#{item_id}/descriptions/#{language_code}",
            with: { body: payload.to_json },
            response_body: response_body
          )
        end

        def stub_delete_item_description_unexpected_error(item_id, language_code, payload)
          stub_rest_api_request(
            :delete,
            "/v1/entities/items/#{item_id}/descriptions/#{language_code}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        ###########################################################################
        # DELETE /v1/entities/properties/:property_id/descriptions/:language_code
        ###########################################################################
        def stub_delete_property_description(property_id, language_code, payload, response_body: "Description deleted")
          stub_rest_api_request(
            :delete,
            "/v1/entities/properties/#{property_id}/descriptions/#{language_code}",
            with: { body: payload.to_json },
            response_body: response_body
          )
        end

        def stub_delete_property_description_unexpected_error(property_id, language_code, payload)
          stub_rest_api_request(
            :delete,
            "/v1/entities/properties/#{property_id}/descriptions/#{language_code}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end
      end
    end
  end
end
