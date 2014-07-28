module Feedlr
  module Gateway
    # Topics API
    #
    # @see http://developer.feedly.com/v3/topics/
    module Topics
      # Get the list of topics the user has added to their feedly
      #
      # @see http://developer.feedly.com/v3/topics/#get-the-list-of-topics-the-user-has-added-to-their-feedly
      # @return [Feedlr::Collection]
      def user_topics
        build_object(method: :get, path: '/topics')
      end

      # Add a topic to the user feedly account
      #
      # @see http://developer.feedly.com/v3/topics/#add-a-topic-to-the-user-feedly-account
      # @param topic [#to_hash]
      # @return [Feedlr::Success]
      def add_topic(topic)
        build_object(method: :post, path: '/topics', params: topic)
      end

      # Update an existing topic
      #
      # @see http://developer.feedly.com/v3/topics/#update-an-existing-topic
      # @param topic [#to_hash]
      # @return [Feedlr::Success]
      def update_topic(topic)
        build_object(method: :post, path: '/topics', params: topic)
      end

      # Remove a topic from a feedly account
      #
      # @see http://developer.feedly.com/v3/topics/#remove-a-topic-from-a-feedly-account
      # @param topic_id [String]
      # @return [Feedlr::Success]
      def delete_topic(topic_id)
        build_object(method: :delete, path: "/topics/#{CGI.escape(topic_id)}")
      end
    end
  end
end
