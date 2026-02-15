# frozen_string_literal: true

module WikidataAdaptor
  module TestHelpers
    module RestApi
      # WebMock stubs for Wikibase REST API item search endpoints
      module SearchItem
        ########################################
        # GET /v0/search/items
        ########################################
        def stub_search_items(query, lang, limit: 10, offset: 0, response_body: nil)
          stub_rest_api_request(
            :get,
            "/v0/search/items",
            with: {
              query: {
                q: query,
                lang: lang,
                limit: limit,
                offset: offset
              }
            },
            response_body: response_body || {
              results: [
                {
                  id: "Q123",
                  "display-label": {
                    language: "en",
                    value: "potato"
                  },
                  description: {
                    language: "en",
                    value: "staple food"
                  },
                  match: {
                    type: "label",
                    language: "en",
                    text: "potato"
                  }
                },
                {
                  id: "Q234",
                  "display-label": {
                    language: "en",
                    value: "potato"
                  },
                  description: {
                    language: "en",
                    value: "species of plant"
                  },
                  match: {
                    type: "label",
                    language: "en",
                    text: "potato"
                  }
                }
              ]
            }
          )
        end

        #########################################
        # GET /v0/suggest/items
        #########################################
        def stub_suggest_items(query, lang, limit: 10, offset: 0, response_body: nil)
          stub_rest_api_request(
            :get,
            "/v0/suggest/items",
            with: {
              query: {
                q: query,
                lang: lang,
                limit: limit,
                offset: offset
              }
            },
            response_body: response_body || {
              results: [
                {
                  id: "Q456",
                  "display-label": {
                    language: "en",
                    value: "drinking water"
                  },
                  description: {
                    language: "en",
                    value: "water safe for consumption"
                  },
                  match: {
                    type: "alias",
                    language: "en",
                    text: "potable water"
                  }
                },
                {
                  id: "Q123",
                  "display-label": {
                    language: "en",
                    value: "potato"
                  },
                  description: {
                    language: "en",
                    value: "staple food"
                  },
                  match: {
                    type: "label",
                    language: "en",
                    text: "potato"
                  }
                }
              ]
            }
          )
        end
      end
    end
  end
end
