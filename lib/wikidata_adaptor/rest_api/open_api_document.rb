# frozen_string_literal: true

module WikidataAdaptor
  class RestApi
    # https://doc.wikimedia.org/Wikibase/master/js/rest-api/#/OpenAPI%20document
    module OpenApiDocument
      # Retrieve the OpenAPI document
      #
      # @return [Hash] The OpenAPI document.
      def get_openapi_document
        get_json("#{endpoint}/openapi.json")
      end
    end
  end
end
