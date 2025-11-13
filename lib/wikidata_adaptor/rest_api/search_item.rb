# frozen_string_literal: true

module WikidataAdaptor
  class RestApi
    # https://doc.wikimedia.org/Wikibase/master/js/rest-api/#/item%20search
    module SearchItem
      # Simple Item search by label and aliases
      #
      # @param [String] query The search query, for example "potato".
      # @param [String] lang The language to search labels in, for example "en".
      # @param [Integer] limit The maximum number of results to return.
      # @param [Integer] offset The number of results to skip (for pagination).
      #
      # @return [Hash] Search results.
      def search_items(query, lang, limit: 10, offset: 0)
        params = {
          q: query,
          lang: lang,
          limit: limit,
          offset: offset
        }
        get_json("#{endpoint}/v0/search/items", params: params)
      end

      # Simple Item search by prefix, for labels and aliases
      #
      # @param [String] query The search query prefix, for example "pota".
      # @param [String] lang The language to search labels in, for example "en".
      # @param [Integer] limit The maximum number of results to return.
      # @param [Integer] offset The number of results to skip (for pagination).
      #
      # @return [Hash] Suggestion results.
      def suggest_items(query, lang, limit: 10, offset: 0)
        params = {
          q: query,
          lang: lang,
          limit: limit,
          offset: offset
        }
        get_json("#{endpoint}/v0/suggest/items", params: params)
      end
    end
  end
end
