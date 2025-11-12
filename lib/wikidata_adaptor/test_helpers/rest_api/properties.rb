# frozen_string_literal: true

module WikidataAdaptor
  module TestHelpers
    module RestApi
      module Properties
        ###############################
        # GET /entities/properties/:property_id
        ###############################
        def stub_get_property(property_id, response_body = nil)
          stub_rest_api_request(
            :get,
            "/entities/properties/#{property_id}",
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
            "/entities/properties/#{property_id}",
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
            "/entities/properties/#{property_id}",
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
            "/entities/properties/#{property_id}",
            response_status: 500,
            response_body: {
              code: "unexpected-error",
              message: "Unexpected Error"
            }
          )
        end
      end
    end
  end
end
