module Feedlr
  module Gateway
    # Feeds API
    #
    # @see http://developer.feedly.com/v3/feeds/
    module Feeds
      # Get the metadata about a specific feed
      #
      # @see http://developer.feedly.com/v3/feeds/#get-the-metadata-about-a-specific-feed
      # @param feed_id [String]
      # @return [Feedlr::Base]
      def feed(feed_id)
        feeds([feed_id]).first
      end

      # Get the metadata for a list of feeds
      #
      # @see http://developer.feedly.com/v3/feeds/#get-the-metadata-for-a-list-of-feeds
      # @param feeds_ids [#to_ary] list of ids
      # @return [Feedlr::Collection]
      def feeds(feeds_ids)
        request_with_object(method: :post,
                            path: '/feeds/.mget',
                            params: feeds_ids)
      end
    end
  end
end
