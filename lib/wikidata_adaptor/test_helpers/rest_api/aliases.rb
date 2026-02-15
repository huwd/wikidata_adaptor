# frozen_string_literal: true

module WikidataAdaptor
  module TestHelpers
    module RestApi
      # WebMock stubs for Wikibase REST API alias endpoints
      module Aliases
        ######################################
        # GET /v1/entities/items/:item_id/aliases
        ######################################
        def stub_get_item_aliases(item_id)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/aliases",
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
        # GET /v1/entities/items/:item_id/aliases/:language_code
        #####################################################
        def stub_get_item_alias(item_id, language_code)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/aliases/#{language_code}",
            response_body: [
              "Douglas Noel Adams",
              "Douglas Noël Adams"
            ]
          )
        end

        ############################################################
        # POST /v1/entities/items/:item_id/aliases/:language_code
        ############################################################
        def stub_post_item_aliases(item_id, language_code, payload, response_body: nil)
          stub_rest_api_request(
            :post,
            "/v1/entities/items/#{item_id}/aliases/#{language_code}",
            response_status: 200,
            with: { body: payload.to_json },
            response_body: response_body || ["Douglas Noel Adams", "Douglas Noël Adams"]
          )
        end

        # Stub POST item aliases request returning 201 Created
        #
        # @param [String] item_id The item ID
        # @param [String] language_code The language code
        # @param [Hash] payload The request payload
        # @param [Array<String>, nil] response_body Optional custom response
        #
        # @return [WebMock::RequestStub]
        def stub_post_item_aliases_created(item_id, language_code, payload, response_body: nil)
          stub_rest_api_request(
            :post,
            "/v1/entities/items/#{item_id}/aliases/#{language_code}",
            response_status: 201,
            with: { body: payload.to_json },
            response_body: response_body || ["Douglas Noel Adams", "Douglas Noël Adams"]
          )
        end

        # Stub POST item aliases request returning 500 error
        #
        # @param [String] item_id The item ID
        # @param [String] language_code The language code
        # @param [Hash] payload The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_post_item_aliases_unexpected_error(item_id, language_code, payload)
          stub_rest_api_request(
            :post,
            "/v1/entities/items/#{item_id}/aliases/#{language_code}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: {
              code: "unexpected-error",
              message: "Unexpected Error"
            }
          )
        end

        ########################################
        # GET /v1/entities/properties/:property_id/aliases
        ########################################
        def stub_get_property_aliases(property_id)
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}/aliases",
            response_body: {
              en: ["is a"],
              fr: ["est un"]
            }
          )
        end

        ########################################################
        # GET /v1/entities/properties/:property_id/aliases/:language_code
        ########################################################
        def stub_get_property_alias(property_id, language_code)
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}/aliases/#{language_code}",
            response_body: ["is a"]
          )
        end

        ################################################################
        # POST /v1/entities/properties/:property_id/aliases/:language_code
        ################################################################
        def stub_post_property_aliases(property_id, language_code, payload, response_body: nil)
          stub_rest_api_request(
            :post,
            "/v1/entities/properties/#{property_id}/aliases/#{language_code}",
            response_status: 200,
            with: { body: payload.to_json },
            response_body: response_body || ["is a", "is an"]
          )
        end

        # Stub POST property aliases request returning 201 Created
        #
        # @param [String] property_id The property ID
        # @param [String] language_code The language code
        # @param [Hash] payload The request payload
        # @param [Array<String>, nil] response_body Optional custom response
        #
        # @return [WebMock::RequestStub]
        def stub_post_property_aliases_created(property_id, language_code, payload, response_body: nil)
          stub_rest_api_request(
            :post,
            "/v1/entities/properties/#{property_id}/aliases/#{language_code}",
            response_status: 201,
            with: { body: payload.to_json },
            response_body: response_body || ["is a", "is an"]
          )
        end

        # Stub POST property aliases request returning 500 error
        #
        # @param [String] property_id The property ID
        # @param [String] language_code The language code
        # @param [Hash] payload The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_post_property_aliases_unexpected_error(property_id, language_code, payload)
          stub_rest_api_request(
            :post,
            "/v1/entities/properties/#{property_id}/aliases/#{language_code}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: {
              code: "unexpected-error",
              message: "Unexpected Error"
            }
          )
        end

        ###########################################
        # PATCH /v1/entities/items/:item_id/aliases
        ###########################################
        def stub_patch_item_aliases(item_id, payload, response_body: nil)
          stub_rest_api_request(
            :patch,
            "/v1/entities/items/#{item_id}/aliases",
            with: { body: payload.to_json },
            response_body: response_body || {
              en: ["Douglas Noel Adams", "Douglas Noël Adams", "DNA"],
              fr: ["Douglas Noel Adams"]
            }
          )
        end

        # Stub PATCH item aliases request returning 500 error
        #
        # @param [String] item_id The item ID
        # @param [Hash] payload The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_patch_item_aliases_unexpected_error(item_id, payload)
          stub_rest_api_request(
            :patch,
            "/v1/entities/items/#{item_id}/aliases",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        #################################################
        # PATCH /v1/entities/properties/:property_id/aliases
        #################################################
        def stub_patch_property_aliases(property_id, payload, response_body: nil)
          stub_rest_api_request(
            :patch,
            "/v1/entities/properties/#{property_id}/aliases",
            with: { body: payload.to_json },
            response_body: response_body || { en: ["is a", "is an"], fr: ["est un"] }
          )
        end

        # Stub PATCH property aliases request returning 500 error
        #
        # @param [String] property_id The property ID
        # @param [Hash] payload The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_patch_property_aliases_unexpected_error(property_id, payload)
          stub_rest_api_request(
            :patch,
            "/v1/entities/properties/#{property_id}/aliases",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end
      end
    end
  end
end
