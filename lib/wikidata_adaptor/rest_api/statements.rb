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
        get_json("#{endpoint}/entities/items/#{CGI.escape(item_id)}/statements#{query}")
      end

      # Retrieve a single Statement from an Item.
      def get_item_statement(item_id, statement_id)
        get_json("#{endpoint}/entities/items/#{CGI.escape(item_id)}/statements/#{statement_id}")
      end

      # Retrieve a single Statement (global).
      def get_statement(statement_id)
        get_json("#{endpoint}/statements/#{statement_id}")
      end

      # Retrieve Statements from a Property.
      def get_property_statements(property_id)
        get_json("#{endpoint}/entities/properties/#{CGI.escape(property_id)}/statements")
      end

      # Retrieve a single Statement from a Property.
      def get_property_statement(property_id, statement_id)
        get_json("#{endpoint}/entities/properties/#{CGI.escape(property_id)}/statements/#{statement_id}")
      end
    end
  end
end
