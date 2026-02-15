# frozen_string_literal: true

require_relative "support/support"
module WikidataAdaptor
  module TestHelpers
    module RestApi
      # WebMock stubs for Wikibase REST API items endpoints
      module Items
        include WikidataAdaptor::TestHelpers::RestApi::Support

        ###############################
        # GET /v1/entities/items/:item_id
        ###############################
        def stub_get_item(item_id, response_body = nil)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}",
            response_body: response_body || load_path_example(
              "/v1/entities/items/{item_id}", "get"
            )
          )
        end

        # Stub GET item request returning 400 invalid item error
        #
        # @param item_id [String] The item ID
        #
        # @return [WebMock::RequestStub]
        def stub_get_item_invalid_item(item_id)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}",
            response_status: 400,
            response_body: {
              code: "invalid-item-id",
              message: "Not a valid item ID: {#{item_id}}"
            }
          )
        end

        # Stub GET item request returning 404 not found error
        #
        # @param item_id [String] The item ID
        #
        # @return [WebMock::RequestStub]
        def stub_get_item_not_found(item_id)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}",
            response_status: 404,
            response_body: {
              code: "item-not-found",
              message: "Could not find an item with the ID: {#{item_id}}"
            }
          )
        end

        # Stub GET item request returning 500 error
        #
        # @param item_id [String] The item ID
        #
        # @return [WebMock::RequestStub]
        def stub_get_item_unexpected_error(item_id)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}",
            response_status: 500,
            response_body: {
              code: "unexpected-error",
              message: "Unexpected Error"
            }
          )
        end

        ###############################
        # POST /v1/entities/items
        ###############################
        def stub_post_item(payload, response_body = nil)
          stub_rest_api_request(
            :post,
            "/v1/entities/items",
            response_status: 201,
            with: { body: payload.to_json },
            response_body: response_body || posted_item_response_fixture.to_json
          )
        end

        # Stub POST item request returning 400 invalid item error
        #
        # @param response_body [Hash, nil] Optional response body
        #
        # @return [WebMock::RequestStub]
        def stub_post_item_invalid_item(response_body = nil)
          stub_rest_api_request(
            :post,
            "/v1/entities/items",
            response_status: 400,
            response_body: response_body || {
              code: "invalid-item-data",
              message: "The provided item data is invalid."
            }
          )
        end

        # Stub POST item request returning 403 access denied error
        #
        # @return [WebMock::RequestStub]
        def stub_post_item_access_denied
          stub_rest_api_request(
            :post,
            "/v1/entities/items",
            response_status: 403,
            response_body: {
              code: "permission-denied",
              message: "Access to resource is denied",
              context: {
                denial_reason: "{reason_code}",
                denial_context: "{additional_context}"
              }
            }
          )
        end

        # Stub POST item request returning 422 data policy violation error
        #
        # @return [WebMock::RequestStub]
        def stub_post_item_data_policy_violation
          stub_rest_api_request(
            :post,
            "/v1/entities/items",
            response_status: 422,
            response_body: {
              code: "data-policy-violation",
              message: "Edit violates data policy",
              context: {
                violation: "{violation_code}",
                violation_context: {
                  some: "context"
                }
              }
            }
          )
        end

        # Stub POST item request returning 429 request limit reached error
        #
        # @return [WebMock::RequestStub]
        def stub_post_item_request_limit_reached
          stub_rest_api_request(
            :post,
            "/v1/entities/items",
            response_status: 429,
            response_body: {
              code: "request-limit-reached",
              message: "Exceeded the limit of actions that can be performed in a given span of time",
              context: {
                reason: "{reason_code}"
              }
            }
          )
        end

        # Stub POST item request returning 500 error
        #
        # @param payload [Hash] The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_post_item_unexpected_error(payload)
          stub_rest_api_request(
            :post,
            "/v1/entities/items",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: {
              code: "unexpected-error",
              message: "Unexpected Error"
            }
          )
        end

        ################################
        # PATCH /v1/entities/items/:item_id
        ################################
        def stub_patch_item(item_id, payload, response_body: nil)
          stub_rest_api_request(
            :patch,
            "/v1/entities/items/#{item_id}",
            with: { body: payload.to_json },
            response_body: response_body || load_path_example(
              "/v1/entities/items/{item_id}", "get"
            )
          )
        end

        # Stub PATCH item request returning 500 error
        #
        # @param item_id [String] The item ID
        # @param payload [Hash] The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_patch_item_unexpected_error(item_id, payload)
          stub_rest_api_request(
            :patch,
            "/v1/entities/items/#{item_id}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end
      end
    end
  end
end
