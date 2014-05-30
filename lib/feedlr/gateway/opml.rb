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
      # ```ruby
      # import_opml(file_path)
      # import_opml(io_obj)
      # import_opml(pathname_obj)
      # ```
      # @param file [#to_str, #read]
      # @return [Feedlr::Success]
      def import_opml(file)
        contents = read_file_contents(file)
        build_object(:post, '/opml', contents,
                     :'Content-Type' => 'text/xml')
      end

    end
  end
end
