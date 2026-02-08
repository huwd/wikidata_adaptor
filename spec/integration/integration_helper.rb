# frozen_string_literal: true

require "wikidata_adaptor/rest_api"
require "net/http"
require "json"
require "securerandom"
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

      def unique_label(prefix)
        "#{prefix} #{SecureRandom.hex(4)}"
      end

      def create_item!(labels: { "en" => unique_label("item") }, descriptions: nil, aliases: nil)
        retries = 0
        begin
          payload = {
            "item" => {
              "labels" => labels
            },
            "comment" => "wikidata_adaptor integration seed"
          }
          payload["item"]["descriptions"] = descriptions if descriptions
          payload["item"]["aliases"] = aliases if aliases

          api_client.post_item(payload).parsed_content
        rescue ApiAdaptor::HTTPTooManyRequests
          retries += 1
          raise if retries > 5

          sleep(retries * 5)
          retry
        rescue ApiAdaptor::HTTPUnauthorized, ApiAdaptor::HTTPForbidden => e
          skip "Wikibase refused writes (#{e.class}). Set WIKIBASE_BEARER_TOKEN or configure the local instance to allow writes."
        end
      end

      def create_property!(data_type: "string", labels: { "en" => unique_label("property") }, descriptions: nil, aliases: nil)
        payload = {
          "property" => {
            "data_type" => data_type,
            "labels" => labels
          },
          "comment" => "wikidata_adaptor integration seed"
        }
        payload["property"]["descriptions"] = descriptions if descriptions
        payload["property"]["aliases"] = aliases if aliases

        uri = URI.parse("#{wikibase_endpoint}/v1/entities/properties")

        retries = 0
        begin
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = uri.scheme == "https"

          req = Net::HTTP::Post.new(uri)
          req["Content-Type"] = "application/json"
          token = wikibase_bearer_token
          req["Authorization"] = "Bearer #{token}" if token && !token.empty?
          req.body = payload.to_json

          res = http.request(req)

          if res.code == "429"
            retries += 1
            raise "Property creation rate limited after #{retries} retries" if retries > 5

            sleep(retries * 5)
            retry
          end

          if res.code == "401" || res.code == "403"
            skip "Wikibase refused writes (#{res.code}). Set WIKIBASE_BEARER_TOKEN or configure the local instance to allow writes."
          end

          raise "Property creation failed (#{res.code}): #{res.body}" unless res.code.start_with?("2")

          JSON.parse(res.body)
        rescue ApiAdaptor::HTTPTooManyRequests
          retries += 1
          raise if retries > 5

          sleep(retries * 5)
          retry
        end
      end
    end
  end
end
