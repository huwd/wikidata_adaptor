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

        #########################################################################
        # GET /v1/entities/items/:item_id/labels_with_language_fallback/:language_code
        #########################################################################
        def stub_get_item_label_with_language_fallback(item_id, language_code)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/labels_with_language_fallback/#{language_code}",
            response_body: "Douglas Adams"
          )
        end

        #########################################################################
        # GET /v1/entities/items/:item_id/labels_with_language_fallback/:language_code
        # -> 307 Location: /v1/entities/items/:item_id/labels/:redirect_language_code
        #########################################################################
        def stub_get_item_label_with_language_fallback_redirect(item_id, language_code,
                                                                redirect_language_code: language_code,
                                                                response_body: "Douglas Adams")
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/labels_with_language_fallback/#{language_code}",
            response_status: 307,
            response_headers: {
              "Location" => "#{WIKIBASE_REST_ENDPOINT}/v1/entities/items/#{item_id}/labels/#{redirect_language_code}"
            },
            response_body: ""
          )

          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/labels/#{redirect_language_code}",
            response_body: response_body
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

        #################################################################################
        # GET /v1/entities/properties/:property_id/labels_with_language_fallback/:language_code
        #################################################################################
        def stub_get_property_label_with_language_fallback(property_id, language_code)
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}/labels_with_language_fallback/#{language_code}",
            response_body: "instance of"
          )
        end

        #################################################################################
        # GET /v1/entities/properties/:property_id/labels_with_language_fallback/:language_code
        # -> 307 Location: /v1/entities/properties/:property_id/labels/:redirect_language_code
        #################################################################################
        def stub_get_property_label_with_language_fallback_redirect(property_id, language_code,
                                                                    redirect_language_code: language_code,
                                                                    response_body: "instance of")
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}/labels_with_language_fallback/#{language_code}",
            response_status: 307,
            response_headers: {
              "Location" => "#{WIKIBASE_REST_ENDPOINT}/v1/entities/properties/#{property_id}/labels/#{redirect_language_code}"
            },
            response_body: ""
          )

          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}/labels/#{redirect_language_code}",
            response_body: response_body
          )
        end

        ##########################################################
        # PUT /v1/entities/items/:item_id/labels/:language_code
        ##########################################################
        def stub_put_item_label(item_id, language_code, payload, response_body: nil)
          stub_rest_api_request(
            :put,
            "/v1/entities/items/#{item_id}/labels/#{language_code}",
            with: { body: payload.to_json },
            response_body: response_body || payload["label"]
          )
        end

        def stub_put_item_label_unexpected_error(item_id, language_code, payload)
          stub_rest_api_request(
            :put,
            "/v1/entities/items/#{item_id}/labels/#{language_code}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        ################################################################
        # PUT /v1/entities/properties/:property_id/labels/:language_code
        ################################################################
        def stub_put_property_label(property_id, language_code, payload, response_body: nil)
          stub_rest_api_request(
            :put,
            "/v1/entities/properties/#{property_id}/labels/#{language_code}",
            with: { body: payload.to_json },
            response_body: response_body || payload["label"]
          )
        end

        def stub_put_property_label_unexpected_error(property_id, language_code, payload)
          stub_rest_api_request(
            :put,
            "/v1/entities/properties/#{property_id}/labels/#{language_code}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        ##########################################
        # PATCH /v1/entities/items/:item_id/labels
        ##########################################
        def stub_patch_item_labels(item_id, payload, response_body: nil)
          stub_rest_api_request(
            :patch,
            "/v1/entities/items/#{item_id}/labels",
            with: { body: payload.to_json },
            response_body: response_body || { en: "Douglas Noel Adams", fr: "Douglas Adams" }
          )
        end

        def stub_patch_item_labels_unexpected_error(item_id, payload)
          stub_rest_api_request(
            :patch,
            "/v1/entities/items/#{item_id}/labels",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        ################################################
        # PATCH /v1/entities/properties/:property_id/labels
        ################################################
        def stub_patch_property_labels(property_id, payload, response_body: nil)
          stub_rest_api_request(
            :patch,
            "/v1/entities/properties/#{property_id}/labels",
            with: { body: payload.to_json },
            response_body: response_body || { en: "is instance of", fr: "est un(e)" }
          )
        end

        def stub_patch_property_labels_unexpected_error(property_id, payload)
          stub_rest_api_request(
            :patch,
            "/v1/entities/properties/#{property_id}/labels",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end
      end
    end
  end
end
