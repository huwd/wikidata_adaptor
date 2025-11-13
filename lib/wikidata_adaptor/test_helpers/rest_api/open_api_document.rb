# frozen_string_literal: true

module WikidataAdaptor
  module TestHelpers
    module RestApi
      # https://doc.wikimedia.org/Wikibase/master/js/rest-api/#/OpenAPI%20document/getOpenApiDoc
      module OpenApiDocument
        ##################################
        # GET /v1/openapi.json
        ##################################
        def stub_get_openapi_document(response_body = nil)
          stub_rest_api_request(
            :get,
            "/v1/openapi.json",
            response_body: response_body || {
              openapi: "3.0.0",
              info: {
                title: "Wikibase REST API",
                version: "...",
                description: "OpenAPI definition of Wikibase REST API"
              },
              paths: {}
            }
          )
        end
      end
    end
  end
end
