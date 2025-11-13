# frozen_string_literal: true

module WikidataAdaptor
  module TestHelpers
    module RestApi
      module Statements
        #########################################
        # GET /v1/entities/items/:item_id/statements
        #########################################
        def stub_get_item_statements(item_id, response_body = nil)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/statements",
            response_body: response_body || {
              additionalProp1: [
                {
                  id: "Q11$6403c562-401a-2b26-85cc-8327801145e1",
                  rank: "normal",
                  property: { id: "P92", "data-type": "string" },
                  value: { content: "I am a goat", type: "value" },
                  qualifiers: [],
                  references: []
                }
              ]
            }
          )
        end

        ########################################################
        # GET /v1/entities/items/:item_id/statements/:statement_id
        ########################################################
        def stub_get_item_statement(item_id, statement_id)
          stub_rest_api_request(
            :get,
            "/v1/entities/items/#{item_id}/statements/#{statement_id}",
            response_body: {
              id: statement_id.to_s,
              rank: "normal",
              property: { id: "P92", "data-type": "string" },
              value: { content: "I am a goat", type: "value" },
              qualifiers: [],
              references: []
            }
          )
        end

        ###############################
        # GET /v1/statements/:statement_id
        ###############################
        def stub_get_statement(statement_id)
          stub_rest_api_request(
            :get,
            "/v1/statements/#{statement_id}",
            response_body: {
              id: statement_id.to_s,
              rank: "normal",
              property: { id: "P92", "data-type": "string" },
              value: { content: "I am a goat", type: "value" },
              qualifiers: [],
              references: []
            }
          )
        end

        ############################################
        # GET /v1/entities/properties/:property_id/statements
        ############################################
        def stub_get_property_statements(property_id, response_body = nil)
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}/statements",
            response_body: response_body || {}
          )
        end

        ##################################################################
        # GET /v1/entities/properties/:property_id/statements/:statement_id
        ##################################################################
        def stub_get_property_statement(property_id, statement_id)
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}/statements/#{statement_id}",
            response_body: {
              id: statement_id.to_s,
              rank: "normal",
              property: { id: property_id.to_s, "data-type": "wikibase-item" },
              value: { content: "Q5", type: "value" },
              qualifiers: [],
              references: []
            }
          )
        end
      end
    end
  end
end
