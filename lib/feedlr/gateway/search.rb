module Feedlr
  module Gateway
    # Search API
    #
    # @see http://developer.feedly.com/v3/search/
    module Search
      # Find feeds based on title,  url or #topic
      #
      # @see http://developer.feedly.com/v3/search/#find-feeds-based-on-title-url-or-topic
      # @param query [String]
      # @param options [#to_hash]
      # @option options [String] :n number of results. default value is 20
      # @option options [String] :locale hint the search engine
      #  to return feeds in that locale (e.g. "pt",  "fr_FR")
      # @return [Feedlr::Base]
      def search_feeds(query, options = {})
        build_object(method: :get, path: '/search/feeds',
                     params: { q: query }.merge(options.to_hash))
      end

      # Search the content of a stream (Pro only)
      #
      # @see http://developer.feedly.com/v3/search/#search-the-content-of-a-stream-pro-only
      # @param stream_id [String]
      # @param query [String]
      # @param options [#to_hash]
      # @option options [String] :count number of entries to return
      # @option options [String] :newerThan timestamp in ms
      # @option options [String] :continuation a continuation id is used
      #  to page through the content
      # @option options [String] :unreadOnly boolean,  default is false
      # @option options [String] :fields a comma-separated list of fields
      # @option options [String] :minMatches minimum number of
      #  search terms to match before
      # @return [Feedlr::Base]
      def search_stream(stream_id, query, options = {})
        build_object(method: :get, path: '/search/contents',
                     params: { q: query, streamId: stream_id }
                     .merge(options.to_hash))
      end
    end
  end
end
