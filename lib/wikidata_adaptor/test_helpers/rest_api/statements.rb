# frozen_string_literal: true

module WikidataAdaptor
  module TestHelpers
    module RestApi
      # WebMock stubs for Wikibase REST API statements endpoints
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

        ##########################################
        # POST /v1/entities/items/:item_id/statements
        ##########################################
        def stub_post_item_statement(item_id, payload, response_body: nil)
          stub_rest_api_request(
            :post,
            "/v1/entities/items/#{item_id}/statements",
            response_status: 201,
            with: { body: payload.to_json },
            response_body: response_body || {
              id: "Q42$6403c562-401a-2b26-85cc-8327801145e1",
              rank: "normal",
              property: { id: "P92", "data-type": "string" },
              value: { content: "I am a goat", type: "value" },
              qualifiers: [],
              references: []
            }
          )
        end

        # Stub POST item statement request returning 500 error
        #
        # @param item_id [String] The item ID
        # @param payload [Hash] The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_post_item_statement_unexpected_error(item_id, payload)
          stub_rest_api_request(
            :post,
            "/v1/entities/items/#{item_id}/statements",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: {
              code: "unexpected-error",
              message: "Unexpected Error"
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

        ##################################################
        # POST /v1/entities/properties/:property_id/statements
        ##################################################
        def stub_post_property_statement(property_id, payload, response_body: nil)
          stub_rest_api_request(
            :post,
            "/v1/entities/properties/#{property_id}/statements",
            response_status: 201,
            with: { body: payload.to_json },
            response_body: response_body || {
              id: "P31$11111111-2222-3333-4444-555555555555",
              rank: "normal",
              property: { id: property_id.to_s, "data-type": "wikibase-item" },
              value: { content: "Q5", type: "value" },
              qualifiers: [],
              references: []
            }
          )
        end

        # Stub POST property statement request returning 500 error
        #
        # @param property_id [String] The property ID
        # @param payload [Hash] The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_post_property_statement_unexpected_error(property_id, payload)
          stub_rest_api_request(
            :post,
            "/v1/entities/properties/#{property_id}/statements",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: {
              code: "unexpected-error",
              message: "Unexpected Error"
            }
          )
        end

        ############################################################
        # PUT /v1/entities/items/:item_id/statements/:statement_id
        ############################################################
        def stub_put_item_statement(item_id, statement_id, payload, response_body: nil)
          stub_rest_api_request(
            :put,
            "/v1/entities/items/#{item_id}/statements/#{statement_id}",
            with: { body: payload.to_json },
            response_body: response_body || {
              id: statement_id.to_s,
              rank: "normal",
              property: { id: "P92", "data-type": "string" },
              value: { content: "Updated goat", type: "value" },
              qualifiers: [],
              references: []
            }
          )
        end

        # Stub PUT item statement request returning 500 error
        #
        # @param item_id [String] The item ID
        # @param statement_id [String] The statement ID
        # @param payload [Hash] The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_put_item_statement_unexpected_error(item_id, statement_id, payload)
          stub_rest_api_request(
            :put,
            "/v1/entities/items/#{item_id}/statements/#{statement_id}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        ##################################################################
        # PUT /v1/entities/properties/:property_id/statements/:statement_id
        ##################################################################
        def stub_put_property_statement(property_id, statement_id, payload, response_body: nil)
          stub_rest_api_request(
            :put,
            "/v1/entities/properties/#{property_id}/statements/#{statement_id}",
            with: { body: payload.to_json },
            response_body: response_body || {
              id: statement_id.to_s,
              rank: "normal",
              property: { id: property_id.to_s, "data-type": "wikibase-item" },
              value: { content: "Q42", type: "value" },
              qualifiers: [],
              references: []
            }
          )
        end

        # Stub PUT property statement request returning 500 error
        #
        # @param property_id [String] The property ID
        # @param statement_id [String] The statement ID
        # @param payload [Hash] The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_put_property_statement_unexpected_error(property_id, statement_id, payload)
          stub_rest_api_request(
            :put,
            "/v1/entities/properties/#{property_id}/statements/#{statement_id}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        #####################################
        # PUT /v1/statements/:statement_id
        #####################################
        def stub_put_statement(statement_id, payload, response_body: nil)
          stub_rest_api_request(
            :put,
            "/v1/statements/#{statement_id}",
            with: { body: payload.to_json },
            response_body: response_body || {
              id: statement_id.to_s,
              rank: "normal",
              property: { id: "P92", "data-type": "string" },
              value: { content: "Updated goat", type: "value" },
              qualifiers: [],
              references: []
            }
          )
        end

        # Stub PUT statement request returning 500 error
        #
        # @param statement_id [String] The statement ID
        # @param payload [Hash] The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_put_statement_unexpected_error(statement_id, payload)
          stub_rest_api_request(
            :put,
            "/v1/statements/#{statement_id}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        ##############################################################
        # PATCH /v1/entities/items/:item_id/statements/:statement_id
        ##############################################################
        def stub_patch_item_statement(item_id, statement_id, payload, response_body: nil)
          stub_rest_api_request(
            :patch,
            "/v1/entities/items/#{item_id}/statements/#{statement_id}",
            with: { body: payload.to_json },
            response_body: response_body || {
              id: statement_id.to_s,
              rank: "normal",
              property: { id: "P92", "data-type": "string" },
              value: { content: "Patched goat", type: "value" },
              qualifiers: [],
              references: []
            }
          )
        end

        # Stub PATCH item statement request returning 500 error
        #
        # @param item_id [String] The item ID
        # @param statement_id [String] The statement ID
        # @param payload [Hash] The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_patch_item_statement_unexpected_error(item_id, statement_id, payload)
          stub_rest_api_request(
            :patch,
            "/v1/entities/items/#{item_id}/statements/#{statement_id}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        ####################################################################
        # PATCH /v1/entities/properties/:property_id/statements/:statement_id
        ####################################################################
        def stub_patch_property_statement(property_id, statement_id, payload, response_body: nil)
          stub_rest_api_request(
            :patch,
            "/v1/entities/properties/#{property_id}/statements/#{statement_id}",
            with: { body: payload.to_json },
            response_body: response_body || {
              id: statement_id.to_s,
              rank: "normal",
              property: { id: property_id.to_s, "data-type": "wikibase-item" },
              value: { content: "Q99", type: "value" },
              qualifiers: [],
              references: []
            }
          )
        end

        # Stub PATCH property statement request returning 500 error
        #
        # @param property_id [String] The property ID
        # @param statement_id [String] The statement ID
        # @param payload [Hash] The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_patch_property_statement_unexpected_error(property_id, statement_id, payload)
          stub_rest_api_request(
            :patch,
            "/v1/entities/properties/#{property_id}/statements/#{statement_id}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        #####################################
        # PATCH /v1/statements/:statement_id
        #####################################
        def stub_patch_statement(statement_id, payload, response_body: nil)
          stub_rest_api_request(
            :patch,
            "/v1/statements/#{statement_id}",
            with: { body: payload.to_json },
            response_body: response_body || {
              id: statement_id.to_s,
              rank: "normal",
              property: { id: "P92", "data-type": "string" },
              value: { content: "Patched goat", type: "value" },
              qualifiers: [],
              references: []
            }
          )
        end

        # Stub PATCH statement request returning 500 error
        #
        # @param statement_id [String] The statement ID
        # @param payload [Hash] The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_patch_statement_unexpected_error(statement_id, payload)
          stub_rest_api_request(
            :patch,
            "/v1/statements/#{statement_id}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        ###############################################################
        # DELETE /v1/entities/items/:item_id/statements/:statement_id
        ###############################################################
        def stub_delete_item_statement(item_id, statement_id, payload, response_body: "Statement deleted")
          stub_rest_api_request(
            :delete,
            "/v1/entities/items/#{item_id}/statements/#{statement_id}",
            with: { body: payload.to_json },
            response_body: response_body
          )
        end

        # Stub DELETE item statement request returning 500 error
        #
        # @param item_id [String] The item ID
        # @param statement_id [String] The statement ID
        # @param payload [Hash] The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_delete_item_statement_unexpected_error(item_id, statement_id, payload)
          stub_rest_api_request(
            :delete,
            "/v1/entities/items/#{item_id}/statements/#{statement_id}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        #####################################################################
        # DELETE /v1/entities/properties/:property_id/statements/:statement_id
        #####################################################################
        def stub_delete_property_statement(property_id, statement_id, payload, response_body: "Statement deleted")
          stub_rest_api_request(
            :delete,
            "/v1/entities/properties/#{property_id}/statements/#{statement_id}",
            with: { body: payload.to_json },
            response_body: response_body
          )
        end

        # Stub DELETE property statement request returning 500 error
        #
        # @param property_id [String] The property ID
        # @param statement_id [String] The statement ID
        # @param payload [Hash] The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_delete_property_statement_unexpected_error(property_id, statement_id, payload)
          stub_rest_api_request(
            :delete,
            "/v1/entities/properties/#{property_id}/statements/#{statement_id}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end

        ########################################
        # DELETE /v1/statements/:statement_id
        ########################################
        def stub_delete_statement(statement_id, payload, response_body: "Statement deleted")
          stub_rest_api_request(
            :delete,
            "/v1/statements/#{statement_id}",
            with: { body: payload.to_json },
            response_body: response_body
          )
        end

        # Stub DELETE statement request returning 500 error
        #
        # @param statement_id [String] The statement ID
        # @param payload [Hash] The request payload
        #
        # @return [WebMock::RequestStub]
        def stub_delete_statement_unexpected_error(statement_id, payload)
          stub_rest_api_request(
            :delete,
            "/v1/statements/#{statement_id}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end
      end
    end
  end
end
