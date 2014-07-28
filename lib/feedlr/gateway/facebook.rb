module Feedlr
  module Gateway
    # Facebook API
    #
    # @see http://developer.feedly.com/v3/facebook/
    # The following API actions do not have corresponding methods in
    # this module:
    #
    #   * Link Facebook account
    module Facebook
      # Unlink Facebook account
      #
      # @see http://developer.feedly.com/v3/facebook/#unlink-facebook-account
      # @return [Feedlr::Success]
      def unlink_facebook
        request_with_object(method: :delete,
                            path: '/facebook/auth')
      end

      # Get suggested feeds
      #
      # @see http://developer.feedly.com/v3/facebook/#get-suggested-feeds
      # @return [Feedlr::Collection]
      def facebook_suggestions
        request_with_object(method: :get,
                            path: '/facebook/suggestions')
      end
    end
  end
end
