# frozen_string_literal: true

module WikidataAdaptor
  module TestHelpers
    module RestApi
      module SearchProperty
        ########################################
        # GET /v0/search/properties
        ########################################
        def stub_search_properties(query, lang, limit: 10, offset: 0, response_body: nil)
          stub_rest_api_request(
            :get,
            "/v0/search/properties",
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
                  id: "P123",
                  "display-label": {
                    language: "en",
                    value: "taxon name"
                  },
                  description: {
                    language: "en",
                    value: "scientific name of a taxon"
                  },
                  match: {
                    type: "label",
                    language: "en",
                    text: "taxon name"
                  }
                },
                {
                  id: "P234",
                  "display-label": {
                    language: "en",
                    value: "taxon rank"
                  },
                  description: {
                    language: "en",
                    value: "level in a taxonomic hierarchy"
                  },
                  match: {
                    type: "label",
                    language: "en",
                    text: "taxon rank"
                  }
                }
              ]
            }
          )
        end

        #########################################
        # GET /v0/suggest/properties
        #########################################
        def stub_suggest_properties(query, lang, limit: 10, offset: 0, response_body: nil)
          stub_rest_api_request(
            :get,
            "/v0/suggest/properties",
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
                  id: "P123",
                  "display-label": {
                    language: "en",
                    value: "taxon name"
                  },
                  description: {
                    language: "en",
                    value: "scientific name of a taxon"
                  },
                  match: {
                    type: "label",
                    language: "en",
                    text: "taxon name"
                  }
                },
                {
                  id: "P234",
                  "display-label": {
                    language: "en",
                    value: "taxon rank"
                  },
                  description: {
                    language: "en",
                    value: "level in a taxonomic hierarchy"
                  },
                  match: {
                    type: "label",
                    language: "en",
                    text: "taxon rank"
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
