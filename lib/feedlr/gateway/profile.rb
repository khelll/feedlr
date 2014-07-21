module Feedlr
  module Gateway
    # Profile API
    #
    # @see http://developer.feedly.com/v3/profile/
    module Profile
      # Get the profile of the user
      #
      # @see http://developer.feedly.com/v3/profile/#get-the-profile-of-the-user
      # @return [Feedlr::Base]
      def user_profile
        build_object(:get, '/profile')
      end

      # Update the profile of the user
      #
      # @see http://developer.feedly.com/v3/profile/#update-the-profile-of-the-user
      # @param profile [#to_hash]
      # @return [Feedlr::Base]
      def update_profile(profile)
        build_object(:post, '/profile', profile)
      end
    end
  end
end
