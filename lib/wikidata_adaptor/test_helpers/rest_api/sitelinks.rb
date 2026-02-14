# frozen_string_literal: true

module WikidataAdaptor
  module TestHelpers
    module RestApi
      module Sitelinks
        ########################################
        # GET /v1/entities/items/:item_id/sitelinks
        ########################################
        def stub_get_item_sitelinks(item_id, response_body = nil)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/sitelinks",
            response_body: response_body || {
              enwiki: {
                title: "Douglas Adams",
                badges: [],
                url: "https://en.wikipedia.org/wiki/Douglas_Adams"
              },
              frwiki: {
                title: "Douglas Adams",
                badges: [],
                url: "https://fr.wikipedia.org/wiki/Douglas_Adams"
              }
            }
          )
        end

        #####################################################
        # GET /v1/entities/items/:item_id/sitelinks/:site_id
        #####################################################
        def stub_get_item_sitelink(item_id, site_id, response_body = nil)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/sitelinks/#{site_id}",
            response_body: response_body || {
              title: "Douglas Adams",
              badges: [],
              url: "https://en.wikipedia.org/wiki/Douglas_Adams"
            }
          )
        end

        #####################################################
        # PUT /v1/entities/items/:item_id/sitelinks/:site_id
        #####################################################
        def stub_put_item_sitelink(item_id, site_id, payload, response_body: nil)
          stub_rest_api_request(
            :put,
            "/v1/entities/items/#{item_id}/sitelinks/#{site_id}",
            with: { body: payload.to_json },
            response_body: response_body || {
              title: "Douglas Adams",
              badges: [],
              url: "https://en.wikipedia.org/wiki/Douglas_Adams"
            }
          )
        end

        def stub_put_item_sitelink_unexpected_error(item_id, site_id, payload)
          stub_rest_api_request(
            :put,
            "/v1/entities/items/#{item_id}/sitelinks/#{site_id}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        #############################################
        # PATCH /v1/entities/items/:item_id/sitelinks
        #############################################
        def stub_patch_item_sitelinks(item_id, payload, response_body: nil)
          stub_rest_api_request(
            :patch,
            "/v1/entities/items/#{item_id}/sitelinks",
            with: { body: payload.to_json },
            response_body: response_body || {
              enwiki: {
                title: "Douglas Adams",
                badges: [],
                url: "https://en.wikipedia.org/wiki/Douglas_Adams"
              }
            }
          )
        end

        def stub_patch_item_sitelinks_unexpected_error(item_id, payload)
          stub_rest_api_request(
            :patch,
            "/v1/entities/items/#{item_id}/sitelinks",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        ########################################################
        # DELETE /v1/entities/items/:item_id/sitelinks/:site_id
        ########################################################
        def stub_delete_item_sitelink(item_id, site_id, payload, response_body: "Sitelink deleted")
          stub_rest_api_request(
            :delete,
            "/v1/entities/items/#{item_id}/sitelinks/#{site_id}",
            with: { body: payload.to_json },
            response_body: response_body
          )
        end

        def stub_delete_item_sitelink_unexpected_error(item_id, site_id, payload)
          stub_rest_api_request(
            :delete,
            "/v1/entities/items/#{item_id}/sitelinks/#{site_id}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end
      end
    end
  end
end
