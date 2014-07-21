module Feedlr
  module Gateway
    # Subscriptions API
    #
    # @see http://developer.feedly.com/v3/subscriptions/
    module Subscriptions
      # Get the user's subscriptions
      #
      # @see http://developer.feedly.com/v3/subscriptions/#get-the-users-subscriptions
      # @return [Feedlr::Collection]
      def user_subscriptions
        build_object(:get, '/subscriptions')
      end

      # Subscribe to a feed
      #
      # @see http://developer.feedly.com/v3/subscriptions/#subscribe-to-a-feed
      # @param subscription [#to_hash]
      # @return [Feedlr::Base]
      def add_subscription(subscription)
        build_object(:post, '/subscriptions', subscription)
      end

      # Update an existing subscription
      #
      # @see http://developer.feedly.com/v3/subscriptions/#update-an-existing-subscription
      # @param subscription [#to_hash]
      # @return [Feedlr::Success]
      def update_subscription(subscription)
        add_subscription(subscription)
      end

      # Unsubscribe from a feed
      #
      # @see http://developer.feedly.com/v3/subscriptions/#unsubscribe-from-a-feed
      # @param subscription_id [String]
      # @return [Feedlr::Success]
      def delete_subscription(subscription_id)
        build_object(:delete, "/subscriptions/#{CGI.escape(subscription_id)}")
      end
    end
  end
end
