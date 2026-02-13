# frozen_string_literal: true

require_relative "support/support"
module WikidataAdaptor
  module TestHelpers
    module RestApi
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
