module Feedlr
  module Gateway
    # Twitter API
    #
    # @see http://developer.feedly.com/v3/twitter/
    # The following API actions do not have corresponding methods in
    # this module:
    #
    #   * Link Twitter account
    #   * Get suggested feeds (alternate version)
    module Twitter
      # Unlink Twitter account
      #
      # @see http://developer.feedly.com/v3/twitter/#unlink-twitter-account
      # @return [Feedlr::Success]
      def unlink_twitter
        request_with_object(method: :delete,
                            path: '/twitter/auth')
      end

      # Get suggested feeds
      #
      # @see http://developer.feedly.com/v3/twitter/#get-suggested-feeds
      # @return [Feedlr::Collection]
      def twitter_suggestions
        request_with_object(method: :get,
                            path: '/twitter/suggestions')
      end
    end
  end
end
