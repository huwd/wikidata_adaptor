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
      end
    end
  end
end
