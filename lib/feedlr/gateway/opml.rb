module Feedlr
  module Gateway
    # OPML API
    #
    # @see http://developer.feedly.com/v3/opml/
    module Opml
      # Export the user's subscriptions as an OPML file
      #
      # @see http://developer.feedly.com/v3/opml/#export-the-users-subscriptions-as-an-opml-file
      # @return [Feedlr::Base]
      def user_opml
        build_object(:get, '/opml', {}, :'Content-Type' => 'text/xml')
      end

      # Import an OPML
      #
      # @see http://developer.feedly.com/v3/opml/#import-an-opml
      # @param io_stream [IOStream] Any IOStream object
      # @return [Feedlr::Success]
      def import_opml(io_stream)
        build_object(:post, '/opml', io_stream.read,
                     :'Content-Type' => 'text/xml')
      end
    end
  end
end
