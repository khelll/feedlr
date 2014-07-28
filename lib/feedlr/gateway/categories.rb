module Feedlr
  module Gateway
    # Categories API
    #
    # @see http://developer.feedly.com/v3/categories/
    module Categories
      # Get the list of all user categories
      #
      # @see http://developer.feedly.com/v3/categories/get-the-list-of-all-categories
      # @return [Feedlr::Collection]
      def user_categories
        build_object(method: :get, path: '/categories')
      end

      # Change the label of an existing user category
      #
      # @see http://developer.feedly.com/v3/categories/#change-the-label-of-an-existing-category
      # @param category_id [String]
      # @param new_value [String] label's new value
      # @return [Feedlr::Success]
      def change_category_label(category_id, new_value)
        build_object(method: :post,
                     path: "/categories/#{CGI.escape(category_id)}",
                     params: { label: new_value })
      end

      # Delete a user category
      #
      # @see http://developer.feedly.com/v3/categories/#delete-a-category
      # @param category_id [String]
      # @return [Feedlr::Success]
      def delete_category(category_id)
        build_object(method: :delete,
                     path: "/categories/#{CGI.escape(category_id)}")
      end
    end
  end
end
