# frozen_string_literal: true

require_relative "support/support"
module WikidataAdaptor
  module TestHelpers
    module RestApi
      module Properties
        include WikidataAdaptor::TestHelpers::RestApi::Support

        ###############################
        # GET /v1/entities/properties/:property_id
        ###############################
        def stub_get_property(property_id, response_body = nil)
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}",
            response_body: response_body || {
              id: property_id.to_s,
              type: "property",
              labels: {
                en: "instance of",
                fr: "est un(e)"
              },
              descriptions: {
                en: "that class of which this subject is a particular example and member",
                fr: "classe dont ce sujet est un exemple particulier"
              },
              aliases: {
                en: ["is a"],
                fr: ["est un"]
              },
              statements: {}
            }
          )
        end

        def stub_get_property_invalid_property(property_id)
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}",
            response_status: 400,
            response_body: {
              code: "invalid-property-id",
              message: "Not a valid property ID: {#{property_id}}"
            }
          )
        end

        def stub_get_property_not_found(property_id)
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}",
            response_status: 404,
            response_body: {
              code: "property-not-found",
              message: "Could not find a property with the ID: {#{property_id}}"
            }
          )
        end

        def stub_get_property_unexpected_error(property_id)
          stub_rest_api_request(
            :get,
            "/v1/entities/properties/#{property_id}",
            response_status: 500,
            response_body: {
              code: "unexpected-error",
              message: "Unexpected Error"
            }
          )
        end

        ###############################
        # POST /v1/entities/properties
        ###############################
        def stub_post_property(payload, response_body = nil)
          stub_rest_api_request(
            :post,
            "/v1/entities/properties",
            response_status: 201,
            with: { body: payload.to_json },
            response_body: response_body || posted_property_response_fixture.to_json
          )
        end

        def stub_post_property_invalid_property(response_body = nil)
          stub_rest_api_request(
            :post,
            "/v1/entities/properties",
            response_status: 400,
            response_body: response_body || {
              code: "invalid-property-data",
              message: "The provided property data is invalid."
            }
          )
        end

        def stub_post_property_access_denied
          stub_rest_api_request(
            :post,
            "/v1/entities/properties",
            response_status: 403,
            response_body: {
              code: "permission-denied",
              message: "Access to resource is denied",
              context: {
                denial_reason: "{reason_code}",
                denial_context: "{additional_context}"
              }
            }
          )
        end

        def stub_post_property_data_policy_violation
          stub_rest_api_request(
            :post,
            "/v1/entities/properties",
            response_status: 422,
            response_body: {
              code: "data-policy-violation",
              message: "Edit violates data policy",
              context: {
                violation: "{violation_code}",
                violation_context: {
                  some: "context"
                }
              }
            }
          )
        end

        def stub_post_property_request_limit_reached
          stub_rest_api_request(
            :post,
            "/v1/entities/properties",
            response_status: 429,
            response_body: {
              code: "request-limit-reached",
              message: "Exceeded the limit of actions that can be performed in a given span of time",
              context: {
                reason: "{reason_code}"
              }
            }
          )
        end

        def stub_post_property_unexpected_error(payload)
          stub_rest_api_request(
            :post,
            "/v1/entities/properties",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: {
              code: "unexpected-error",
              message: "Unexpected Error"
            }
          )
        end

        ##########################################
        # PATCH /v1/entities/properties/:property_id
        ##########################################
        def stub_patch_property(property_id, payload, response_body: nil)
          stub_rest_api_request(
            :patch,
            "/v1/entities/properties/#{property_id}",
            with: { body: payload.to_json },
            response_body: response_body || {
              id: property_id.to_s,
              type: "property",
              data_type: "string",
              labels: { en: "is instance of" },
              descriptions: { en: "that class of which this subject is a particular example and member" },
              aliases: { en: ["is a"] },
              statements: {}
            }
          )
        end

        def stub_patch_property_unexpected_error(property_id, payload)
          stub_rest_api_request(
            :patch,
            "/v1/entities/properties/#{property_id}",
            response_status: 500,
            with: { body: payload.to_json },
            response_body: { code: "unexpected-error", message: "Unexpected Error" }
          )
        end
      end
    end
  end
end
