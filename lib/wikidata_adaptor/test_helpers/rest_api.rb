# frozen_string_literal: true

require "json"
require "webmock"

module WikidataAdaptor
  module TestHelpers
    module RestApi
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

      ###############################
      # GET /entities/items/:item_id
      ###############################
      def stub_get_item(item_id, response_body = nil)
        stub_rest_api_request(
          :get,
          "/entities/items/#{item_id}",
          response_body: response_body || {
            id: item_id.to_s,
            type: "item",
            labels: {
              en: "Douglas Adams",
              fr: "Douglas Adams"
            },
            descriptions: {
              en: "English science fiction writer and humourist",
              fr: "écrivain de science-fiction et humoriste anglais"
            },
            aliases: {
              en: [
                "Douglas Noel Adams",
                "Douglas Noël Adams"
              ],
              fr: [
                "Douglas Noel Adams"
              ]
            },
            sitelinks: {
              afwiki: {
                title: "Douglas Adams",
                badges: [
                  "Q17437798"
                ],
                url: "https://af.wikipedia.org/wiki/Douglas_Adams"
              },
              arwiki: {
                title: "دوغلاس آدمز",
                badges: [],
                url: "https://ar.wikipedia.org/wiki/%D8%AF%D9%88%D8%BA%D9%84%D8%A7%D8%B3_%D8%A2%D8%AF%D9%85%D8%B2"
              }
            },
            statements: {
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
          }
        )
      end

      def stub_get_item_invalid_item(item_id)
        stub_rest_api_request(
          :get,
          "/entities/items/#{item_id}",
          response_status: 400,
          response_body: {
            code: "invalid-item-id",
            message: "Not a valid item ID: {#{item_id}}"
          }
        )
      end

      def stub_get_item_not_found(item_id)
        stub_rest_api_request(
          :get,
          "/entities/items/#{item_id}",
          response_status: 404,
          response_body: {
            code: "item-not-found",
            message: "Could not find an item with the ID: {#{item_id}}"
          }
        )
      end

      def stub_get_item_unexpected_error(item_id)
        stub_rest_api_request(
          :get,
          "/entities/items/#{item_id}",
          response_status: 500,
          response_body: {
            code: "unexpected-error",
            message: "Unexpected Error"
          }
        )
      end

      #####################################
      # GET /entities/items/:item_id/labels
      #####################################
      def stub_get_item_labels(item_id)
        stub_rest_api_request(
          :get,
          "/entities/items/#{item_id}/labels",
          response_body: {
            en: "Douglas Adams",
            fr: "Douglas Adams"
          }
        )
      end

      ####################################################
      # GET /entities/items/:item_id/labels/:language_code
      ####################################################
      def stub_get_item_label(item_id, language_code)
        stub_rest_api_request(
          :get,
          "/entities/items/#{item_id}/labels/#{language_code}",
          response_body: "Douglas Adams"
        )
      end

      ###########################################
      # GET /entities/items/:item_id/descriptions
      ###########################################
      def stub_get_item_descriptions(item_id)
        stub_rest_api_request(
          :get,
          "/entities/items/#{item_id}/descriptions",
          response_body: {
            en: "English science fiction writer and humourist",
            fr: "écrivain de science-fiction et humoriste anglais"
          }
        )
      end

      ##########################################################
      # GET /entities/items/:item_id/descriptions/:language_code
      ##########################################################
      def stub_get_item_description(item_id, language_code)
        stub_rest_api_request(
          :get,
          "/entities/items/#{item_id}/descriptions/#{language_code}",
          response_body: "English science fiction writer and humourist"
        )
      end

      ######################################
      # GET /entities/items/:item_id/aliases
      ######################################
      def stub_get_item_aliases(item_id)
        stub_rest_api_request(
          :get,
          "/entities/items/#{item_id}/aliases",
          response_body: {
            en: [
              "Douglas Noel Adams",
              "Douglas Noël Adams"
            ],
            fr: [
              "Douglas Noel Adams"
            ]
          }
        )
      end

      #####################################################
      # GET /entities/items/:item_id/aliases/:language_code
      #####################################################
      def stub_get_item_alias(item_id, language_code)
        stub_rest_api_request(
          :get,
          "/entities/items/#{item_id}/aliases/#{language_code}",
          response_body: [
            "Douglas Noel Adams",
            "Douglas Noël Adams"
          ]
        )
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

      ########################################
      # GET /entities/items/:item_id/sitelinks
      ########################################
      def stub_get_item_sitelinks(item_id, response_body = nil)
        stub_rest_api_request(
          :get,
          "/entities/items/#{item_id}/sitelinks",
          response_body: response_body || {
            enwiki: {
              title: "Douglas Adams",
              badges: [],
              url: "https://en.wikipedia.org/wiki/Douglas_Adams"
            },
            frwiki: {
              title: "Douglas Adams",
              badges: [],
              url: "https://fr.wikipedia.org/wiki/Douglas_Adams"
            }
          }
        )
      end

      #####################################################
      # GET /entities/items/:item_id/sitelinks/:site_id
      #####################################################
      def stub_get_item_sitelink(item_id, site_id, response_body = nil)
        stub_rest_api_request(
          :get,
          "/entities/items/#{item_id}/sitelinks/#{site_id}",
          response_body: response_body || {
            title: "Douglas Adams",
            badges: [],
            url: "https://en.wikipedia.org/wiki/Douglas_Adams"
          }
        )
      end

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

      ###########################################
      # GET /entities/properties/:property_id/labels
      ###########################################
      def stub_get_property_labels(property_id)
        stub_rest_api_request(
          :get,
          "/entities/properties/#{property_id}/labels",
          response_body: {
            en: "instance of",
            fr: "est un(e)"
          }
        )
      end

      ########################################################
      # GET /entities/properties/:property_id/labels/:language_code
      ########################################################
      def stub_get_property_label(property_id, language_code)
        stub_rest_api_request(
          :get,
          "/entities/properties/#{property_id}/labels/#{language_code}",
          response_body: "instance of"
        )
      end

      ##############################################
      # GET /entities/properties/:property_id/descriptions
      ##############################################
      def stub_get_property_descriptions(property_id)
        stub_rest_api_request(
          :get,
          "/entities/properties/#{property_id}/descriptions",
          response_body: {
            en: "that class of which this subject is a particular example and member",
            fr: "classe dont ce sujet est un exemple particulier"
          }
        )
      end

      private

      def prepare_response(response_body, session)
        if response_body.is_a?(Hash)
          response_body.merge(session: session).compact.to_json
        elsif response_body.is_a?(Array) || response_body.is_a?(String)
          response_body
        end
      end
    end
  end
end
