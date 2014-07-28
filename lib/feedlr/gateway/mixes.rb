module Feedlr
  module Gateway
    # Mixes API
    #
    # @see http://developer.feedly.com/v3/mixes/
    module Mixes
      # Get a mix of the most engaging content available in a stream
      #
      # @see http://developer.feedly.com/v3/mixes/#get-a-mix-of-the-most-engaging-content-available-in-a-stream
      # @param stream_id [String]
      # @param options [#to_hash]
      # @option options [String] :count number of entry ids to return.
      #  default is 3. max is 20
      # @option options [String] :unreadOnly boolean default value is false
      # @option options [String] :hours hour of the day
      # @option options [String] :newerThan timestamp in ms
      # @option options [String] :backfill if "hours" is provided,
      #  and there aren't enough articles to match the entry count requested,
      #  the server will look back in time to find more articles.
      #  Articles from the first n hours will be returned first
      # @option options [String] :locale preferred locale for results
      # @return [Feedlr::Base]
      def stream_most_engaging(stream_id, options = {})
        build_object(method: :get, path: '/mixes/contents',
                     params: { streamId: stream_id }.merge(options.to_hash))
      end
    end
  end
end
