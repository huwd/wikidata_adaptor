# frozen_string_literal: true

require "json"
require "webmock"

module WikidataAdaptor
  module TestHelpers
    module RestApi
      require_relative "rest_api/aliases"
      require_relative "rest_api/items"
      require_relative "rest_api/sitelinks"
      require_relative "rest_api/properties"
      require_relative "rest_api/labels"
      require_relative "rest_api/descriptions"
      include WikidataAdaptor::TestHelpers::RestApi::Aliases
      include WikidataAdaptor::TestHelpers::RestApi::Items
      include WikidataAdaptor::TestHelpers::RestApi::Sitelinks
      include WikidataAdaptor::TestHelpers::RestApi::Properties
      include WikidataAdaptor::TestHelpers::RestApi::Labels
      include WikidataAdaptor::TestHelpers::RestApi::Descriptions

      WIKIBASE_REST_ENDPOINT = ENV["WIKIBASE_REST_ENDPOINT"] || "https://test.test/w/rest.php/wikibase/v0"

      def stub_rest_api_request(method, path, with: {}, response_status: 200, response_body: {}, session: nil)
        with.merge!(headers: { WikidataAdaptor::RestApi::AUTH_HEADER_NAME => session }) if session
        session = nil if response_status >= 400
        to_return = { status: response_status, body: prepare_response(response_body, session) }
        if with.empty?
          stub_request(method, "#{WIKIBASE_REST_ENDPOINT}#{path}").to_return(**to_return)
        else
          stub_request(method, "#{WIKIBASE_REST_ENDPOINT}#{path}").with(**with).to_return(**to_return)
        end
      end

      #########################################
      # GET /entities/items/:item_id/statements
      #########################################
      def stub_get_item_statements(item_id, response_body = nil)
        stub_rest_api_request(
          :get,
          "/entities/items/#{item_id}/statements",
          response_body: response_body || {
            additionalProp1: [
              {
                id: "Q11$6403c562-401a-2b26-85cc-8327801145e1",
                rank: "normal",
                property: {
                  id: "P92",
                  "data-type": "string"
                },
                value: {
                  content: "I am a goat",
                  type: "value"
                },
                qualifiers: [],
                references: []
              }
            ],
            additionalProp2: [
              {
                id: "Q11$6403c562-401a-2b26-85cc-8327801145e1",
                rank: "normal",
                property: {
                  id: "P92",
                  "data-type": "string"
                },
                value: {
                  content: "I am a goat",
                  type: "value"
                },
                qualifiers: [],
                references: []
              }
            ],
            additionalProp3: [
              {
                id: "Q11$6403c562-401a-2b26-85cc-8327801145e1",
                rank: "normal",
                property: {
                  id: "P92",
                  "data-type": "string"
                },
                value: {
                  content: "I am a goat",
                  type: "value"
                },
                qualifiers: [],
                references: []
              }
            ]
          }
        )
      end

      ########################################################
      # GET /entities/items/:item_id/statements/:statement_id
      ########################################################
      def stub_get_item_statement(item_id, statement_id)
        stub_rest_api_request(
          :get,
          "/entities/items/#{item_id}/statements/#{statement_id}",
          response_body: {
            id: statement_id.to_s,
            rank: "normal",
            property: {
              id: "P92",
              "data-type": "string"
            },
            value: {
              content: "I am a goat",
              type: "value"
            },
            qualifiers: [],
            references: []
          }
        )
      end

      ###############################
      # GET /statements/:statement_id
      ###############################
      def stub_get_statement(statement_id)
        stub_rest_api_request(
          :get,
          "/statements/#{statement_id}",
          response_body: {
            id: statement_id.to_s,
            rank: "normal",
            property: {
              id: "P92",
              "data-type": "string"
            },
            value: {
              content: "I am a goat",
              type: "value"
            },
            qualifiers: [],
            references: []
          }
        )
      end

      ############################################
      # GET /entities/properties/:property_id/statements
      ############################################
      def stub_get_property_statements(property_id, response_body = nil)
        stub_rest_api_request(
          :get,
          "/entities/properties/#{property_id}/statements",
          response_body: response_body || {}
        )
      end

      ##################################################################
      # GET /entities/properties/:property_id/statements/:statement_id
      ##################################################################
      def stub_get_property_statement(property_id, statement_id)
        stub_rest_api_request(
          :get,
          "/entities/properties/#{property_id}/statements/#{statement_id}",
          response_body: {
            id: statement_id.to_s,
            rank: "normal",
            property: {
              id: property_id.to_s,
              "data-type": "wikibase-item"
            },
            value: {
              content: "Q5",
              type: "value"
            },
            qualifiers: [],
            references: []
          }
        )
      end

      private

      def prepare_response(response_body, session)
        case response_body
        when Hash
          response_body.merge(session: session).compact.to_json
        when Array
          response_body.to_json
        else # String or other
          response_body
        end
      end
    end
  end
end
