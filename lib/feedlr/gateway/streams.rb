module Feedlr
  module Gateway
    # Streams API
    #
    # @see http://developer.feedly.com/v3/streams/
    module Streams
      # Get a list of entry ids for a specific stream
      #
      # @see http://developer.feedly.com/v3/streams/#get-a-list-of-entry-ids-for-a-specific-stream
      # @param stream_id [String]
      # @param options [#to_hash]
      # @option options [String] :count mber of entry ids to return.
      #  default is 20. max is 10,000
      # @option options [String] :ranked newest or oldest. default is newest
      # @option options [String] :unreadOnly boolean default value is false
      # @option options [String] :newerThan timestamp in ms
      # @option options [String] :continuation a continuation id is
      #  used to page through the entry ids
      # @return [Feedlr::Base]
      def stream_entries_ids(stream_id, options = {})
        request_with_object(method: :get,
                            path: "/streams/#{CGI.escape(stream_id)}/ids",
                            params: options)
      end
      # Get the content of a stream
      #
      # @see http://developer.feedly.com/v3/streams/#get-the-content-of-a-stream
      # @param stream_id [String]
      # @param options [#to_hash]
      # @option options [String] :count mber of entry ids to return.
      #  default is 20. max is 10, 000
      # @option options [String] :ranked newest or oldest. default is newest
      # @option options [String] :unreadOnly boolean default value is false
      # @option options [String] :newerThan timestamp in ms
      # @option options [String] :continuation a continuation id
      #  is used to page through the entry ids
      # @return [Feedlr::Base]
      def stream_entries_contents(stream_id, options = {})
        request_with_object(method: :get,
                            path: "/streams/#{CGI.escape(stream_id)}/contents",
                            params: options)
      end
    end
  end
end
