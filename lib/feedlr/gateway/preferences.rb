module Feedlr
  module Gateway
    # Preferences API
    #
    # @see http://developer.feedly.com/v3/preferences/
    module Preferences
      # Get the preferences of the user
      #
      # @see http://developer.feedly.com/v3/preferences/#get-the-preferences-of-the-user
      # @return [Feedlr::Base]
      def preferences
        build_object(:get , '/preferences')
      end

      # Update the preferences of the user
      #
      # @see http://developer.feedly.com/v3/preferences/#update-the-preferences-of-the-user
      # @param preferences [#to_hash]
      # @return [Feedlr::Base]
      def update_preferences(preferences)
        build_object(:post , '/preferences' , preferences)
      end
    end
  end
end
