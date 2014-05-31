module Feedlr
  module Gateway
    # Entries API
    #
    # @see http://developer.feedly.com/v3/entries/
    module Entries
      # Get the content of an entry
      #
      # @see user_entries
      # @param entry_id [String]
      # @return [Feedlr::Base]
      def user_entry(entry_id)
        user_entries([entry_id]).first
      end

      # Get the content for a dynamic list of entries
      #
      # @see http://developer.feedly.com/v3/entries/#get-the-content-for-a-dynamic-list-of-entries
      # @param entries_ids [#to_ary] list of ids
      # @param options [#to_hash]
      # @option options [String] :continuation next cursor id
      # @return [Feedlr::Collection]
      def user_entries(entries_ids ,  options =  {})
        options = options.to_hash
        build_object(:post , '/entries/.mget',
                     continuation: options[:continuation],
                     ids: entries_ids.to_ary
                     )
      end

      # Create and tag an entry
      #
      # @see http://developer.feedly.com/v3/entries/#create-and-tag-an-entry
      # @param entry [#to_hash]
      # @return [String]
      def add_entry(entry)
        build_object(:post , '/entries' ,  entry).first
      end
    end
  end
end
