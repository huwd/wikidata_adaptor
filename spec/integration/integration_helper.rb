# frozen_string_literal: true

require "wikidata_adaptor/rest_api"
require "spec_helper"

module WikidataAdaptor
  module Integration
    module Helpers
      def wikibase_endpoint
        ENV.fetch("WIKIBASE_REST_ENDPOINT")
      rescue KeyError
        skip "Set WIKIBASE_REST_ENDPOINT to your Wikibase REST base, e.g. http://localhost:8080/w/rest.php/wikibase"
      end

      def wikibase_bearer_token
        ENV.fetch("WIKIBASE_BEARER_TOKEN", nil)
      end

      def api_client
        opts = {}
        token = wikibase_bearer_token
        opts[:bearer_token] = token if token && !token.empty?
        WikidataAdaptor::RestApi.new(wikibase_endpoint, opts)
      end

      def create_item!(labels: { "en" => "Integration test label" }, descriptions: nil)
        payload = {
          "item" => {
            "labels" => labels
          },
          "comment" => "wikidata_adaptor integration seed"
        }
        payload["item"]["descriptions"] = descriptions if descriptions

        api_client.post_item(payload).parsed_content
      rescue ApiAdaptor::HTTPUnauthorized, ApiAdaptor::HTTPForbidden => e
        skip "Wikibase refused writes (#{e.class}). Set WIKIBASE_BEARER_TOKEN or configure the local instance to allow writes."
      end
    end
  end
end
