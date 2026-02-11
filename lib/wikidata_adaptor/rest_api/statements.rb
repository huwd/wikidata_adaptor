# frozen_string_literal: true

module WikidataAdaptor
  class RestApi
    # https://doc.wikimedia.org/Wikibase/master/js/rest-api/#/statements
    module Statements
      # Retrieve Statements from an Item.
      #
      # Optional filter:
      #   params[:property] => property ID (e.g., "P31")
      def get_item_statements(item_id, params = { property: nil })
        query = params[:property] ? "?property=#{CGI.escape(params[:property])}" : ""
        get_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}/statements#{query}")
      end

      # Retrieve a single Statement from an Item.
      def get_item_statement(item_id, statement_id)
        get_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}/statements/#{statement_id}")
      end

      # Add a Statement to an Item.
      #
      # @param [String] item_id The ID of the Item.
      # @param [Hash] payload Statement and edit metadata.
      #
      # @return [Hash] The newly created Statement.
      def post_item_statement(item_id, payload)
        post_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}/statements", payload)
      end

      # Retrieve a single Statement (global).
      def get_statement(statement_id)
        get_json("#{endpoint}/v1/statements/#{statement_id}")
      end

      # Retrieve Statements from a Property.
      def get_property_statements(property_id)
        get_json("#{endpoint}/v1/entities/properties/#{CGI.escape(property_id)}/statements")
      end

      # Retrieve a single Statement from a Property.
      def get_property_statement(property_id, statement_id)
        get_json("#{endpoint}/v1/entities/properties/#{CGI.escape(property_id)}/statements/#{statement_id}")
      end

      # Add a Statement to a Property.
      #
      # @param [String] property_id The ID of the Property.
      # @param [Hash] payload Statement and edit metadata.
      #
      # @return [Hash] The newly created Statement.
      def post_property_statement(property_id, payload)
        post_json("#{endpoint}/v1/entities/properties/#{CGI.escape(property_id)}/statements", payload)
      end
    end
  end
end
