module Feedlr
  module Gateway
    # Evernote API
    #
    # @see http://developer.feedly.com/v3/evernote/
    # The following API actions do not have corresponding methods in
    # this module:
    #
    #   * Link Evernote account
    module Evernote
      # Unlink Evernote account
      #
      # @see http://developer.feedly.com/v3/evernote/#unlink-evernote-account
      # @return [Feedlr::Success]
      def unlink_evernote
        build_object(:delete , '/evernote/auth')
      end

      # Get a list of Evernote notebooks (Pro only)
      #
      # @see http://developer.feedly.com/v3/evernote/#get-a-list-of-evernote-notebooks-pro-only
      # @return [Feedlr::Collection]
      def evernote_notebooks
        build_object(:get , '/evernote/notebooks')
      end

      # Save an article as a note (Pro only)
      #
      # @see http://developer.feedly.com/v3/evernote/#save-an-article-as-a-note-pro-only
      # @param entry [Hash]
      # @return [Feedlr::Success]
      def add_to_evernote(entry)
        build_object(:post , '/evernote/note' , entry)
      end
    end
  end
end
