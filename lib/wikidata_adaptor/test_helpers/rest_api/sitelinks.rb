# frozen_string_literal: true

module WikidataAdaptor
  module TestHelpers
    module RestApi
      module Sitelinks
        ########################################
        # GET /entities/items/:item_id/sitelinks
        ########################################
        def stub_get_item_sitelinks(item_id, response_body = nil)
          stub_rest_api_request(
            :get,
            "/entities/items/#{item_id}/sitelinks",
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
        # GET /entities/items/:item_id/sitelinks/:site_id
        #####################################################
        def stub_get_item_sitelink(item_id, site_id, response_body = nil)
          stub_rest_api_request(
            :get,
            "/entities/items/#{item_id}/sitelinks/#{site_id}",
            response_body: response_body || {
              title: "Douglas Adams",
              badges: [],
              url: "https://en.wikipedia.org/wiki/Douglas_Adams"
            }
          )
        end
      end
    end
  end
end
