# frozen_string_literal: true

require "wikidata_adaptor/rest_api"
require "uri"
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
          loop do
            req = Net::HTTP::Post.new(uri)
            req["Content-Type"] = "application/json"
            token = wikibase_bearer_token
            req["Authorization"] = "Bearer #{token}" if token && !token.empty?
            req.body = payload.to_json

            res = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }

            if res.code == "429"
              retries += 1
              raise "Property creation rate limited after #{retries} retries" if retries > 5

              sleep(retries * 5)
              next
            end

            if res.code == "401"
              raise ApiAdaptor::HTTPUnauthorized
            elsif res.code == "403"
              raise ApiAdaptor::HTTPForbidden
            end

            raise "Property creation failed (#{res.code}): #{res.body}" unless res.code.start_with?("2")

            return JSON.parse(res.body)
          end
        rescue ApiAdaptor::HTTPUnauthorized, ApiAdaptor::HTTPForbidden => e
          skip "Wikibase refused writes (#{e.class}). Set WIKIBASE_BEARER_TOKEN or configure the local instance to allow writes."
        end
      end

      # Wait for eventual consistency after a write operation.
      #
      # Wikibase's REST API exhibits eventual consistency: writes (PUT/PATCH/POST) may
      # return successfully before reads (GET) reflect the changes. The write path updates
      # ETags/Last-Modified before the read path serves fresh content, making metadata
      # unreliable for consistency checks.
      #
      # This helper polls with exponential backoff until the read returns the expected value.
      # Empirically, updates usually propagate within 0.5-2s, but under load can take longer
      # due to background job queues (htmlCacheUpdate, cirrusSearchLinksUpdate, etc).
      #
      # @param write_response [ApiAdaptor::Response] The response from the PUT/PATCH operation.
      # @param max_tries [Integer] Maximum number of read attempts (default: 8).
      # @yield A block that performs the read operation and returns a Response object.
      # @return [Object] The read response's parsed_content once it matches the write.
      # @raise [RSpec::Expectations::ExpectationNotMetError] If values don't match after max_tries.
      #
      # @example
      #   put_response = api_client.put_item_label(item_id, "en", { label: "New Label", comment: "test" })
      #   fetched = wait_for_consistency(put_response) do
      #     api_client.get_item_label(item_id, "en")
      #   end
      def wait_for_consistency(write_response, max_tries: 8)
        expected_value = write_response.parsed_content

        last_actual = nil
        max_tries.times do |attempt|
          read_response = yield
          last_actual = read_response.parsed_content

          return last_actual if last_actual == expected_value

          # Exponential backoff: 0.1s, 0.2s, 0.4s, 0.8s, 1.6s, 3.2s, 6.4s
          # Total max wait: ~12.7s across 8 tries
          # Most updates propagate in <1s; this handles pathological cases under load
          sleep(0.1 * (2**attempt)) unless attempt == max_tries - 1
        end

        # If exhausted, fail with clear diagnostics
        raise RSpec::Expectations::ExpectationNotMetError,
              "Expected consistency after #{max_tries} tries.\nExpected: #{expected_value.inspect}\nGot: #{last_actual.inspect}"
      end
    end
  end
end
