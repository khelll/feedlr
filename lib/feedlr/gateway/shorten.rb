module Feedlr
  module Gateway
    # Shorten API
    #
    # @see http://developer.feedly.com/v3/shorten/
    module Shorten
      # Create a shortened URL for an entry
      #
      # @see http://developer.feedly.com/v3/shorten/#create-a-shortened-url-for-an-entry
      # @param entry_id [String]
      # @return [String]
      def shorten_entry(entry_id)
        build_object(:get, "/shorten/entries/#{CGI.escape(entry_id)}")
      end
    end
  end
end
