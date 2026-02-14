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

      # Replace a Statement on an Item.
      #
      # @param [String] item_id The ID of the Item.
      # @param [String] statement_id The Statement ID.
      # @param [Hash] payload Statement and edit metadata.
      #
      # @return [Hash] The replaced Statement.
      def put_item_statement(item_id, statement_id, payload)
        put_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}/statements/#{statement_id}", payload)
      end

      # Replace a Statement on a Property.
      #
      # @param [String] property_id The ID of the Property.
      # @param [String] statement_id The Statement ID.
      # @param [Hash] payload Statement and edit metadata.
      #
      # @return [Hash] The replaced Statement.
      def put_property_statement(property_id, statement_id, payload)
        put_json("#{endpoint}/v1/entities/properties/#{CGI.escape(property_id)}/statements/#{statement_id}", payload)
      end

      # Replace a Statement (global).
      #
      # @param [String] statement_id The Statement ID.
      # @param [Hash] payload Statement and edit metadata.
      #
      # @return [Hash] The replaced Statement.
      def put_statement(statement_id, payload)
        put_json("#{endpoint}/v1/statements/#{statement_id}", payload)
      end

      # Apply JSON Patch operations to a Statement on an Item.
      #
      # @param [String] item_id The ID of the Item.
      # @param [String] statement_id The Statement ID.
      # @param [Hash] payload JSON Patch operations and edit metadata.
      #
      # @return [Hash] The updated Statement.
      def patch_item_statement(item_id, statement_id, payload)
        patch_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}/statements/#{statement_id}", payload)
      end

      # Apply JSON Patch operations to a Statement on a Property.
      #
      # @param [String] property_id The ID of the Property.
      # @param [String] statement_id The Statement ID.
      # @param [Hash] payload JSON Patch operations and edit metadata.
      #
      # @return [Hash] The updated Statement.
      def patch_property_statement(property_id, statement_id, payload)
        patch_json("#{endpoint}/v1/entities/properties/#{CGI.escape(property_id)}/statements/#{statement_id}", payload)
      end

      # Apply JSON Patch operations to a Statement (global).
      #
      # @param [String] statement_id The Statement ID.
      # @param [Hash] payload JSON Patch operations and edit metadata.
      #
      # @return [Hash] The updated Statement.
      def patch_statement(statement_id, payload)
        patch_json("#{endpoint}/v1/statements/#{statement_id}", payload)
      end

      # Delete a Statement from an Item.
      #
      # @param [String] item_id The ID of the Item.
      # @param [String] statement_id The Statement ID.
      # @param [Hash] payload Edit metadata (comment).
      #
      # @return [String] Confirmation message.
      def delete_item_statement(item_id, statement_id, payload)
        delete_json("#{endpoint}/v1/entities/items/#{CGI.escape(item_id)}/statements/#{statement_id}", payload)
      end

      # Delete a Statement from a Property.
      #
      # @param [String] property_id The ID of the Property.
      # @param [String] statement_id The Statement ID.
      # @param [Hash] payload Edit metadata (comment).
      #
      # @return [String] Confirmation message.
      def delete_property_statement(property_id, statement_id, payload)
        delete_json("#{endpoint}/v1/entities/properties/#{CGI.escape(property_id)}/statements/#{statement_id}", payload)
      end

      # Delete a Statement (global).
      #
      # @param [String] statement_id The Statement ID.
      # @param [Hash] payload Edit metadata (comment).
      #
      # @return [String] Confirmation message.
      def delete_statement(statement_id, payload)
        delete_json("#{endpoint}/v1/statements/#{statement_id}", payload)
      end
    end
  end
end
