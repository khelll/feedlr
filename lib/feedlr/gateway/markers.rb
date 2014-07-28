module Feedlr
  module Gateway
    # Markers API
    #
    # @see http://developer.feedly.com/v3/markers/
    module Markers
      # Get the list of unread counts
      #
      # @see http://developer.feedly.com/v3/markers/#get-the-list-of-unread-counts
      # @param options [#to_hash]
      # @option options [String] :autorefresh let's the server know
      #  if this is a background auto-refresh or not
      # @option options [String] :newerThan timestamp in ms. Default is 30 days.
      # @option options [String] :streamId A user or system category
      #  can be passed to restrict the unread count response
      #  to feeds in this category
      # @return [Feedlr::Base]
      def user_unread_counts(options = {})
        options = options.to_hash
        build_object(method: :get, path: '/markers/counts', params: options)
      end

      # Mark an articles as read
      #
      # @see mark_articles_as_read
      # @param article_id [String]
      # @return [Feedlr::Success]
      def mark_article_as_read(article_id)
        mark_articles_as_read([article_id])
      end

      # Mark multiple articles as read
      #
      # @see http://developer.feedly.com/v3/markers/#mark-one-or-multiple-articles-as-read
      # @param articles_ids [#to_ary]
      # @return [Feedlr::Success]
      def mark_articles_as_read(articles_ids)
        build_object(method: :post, path: '/markers',
                     params: { entryIds: articles_ids.to_ary,
                               action: 'markAsRead',
                               type: 'entries' }
                     )
      end

      # Keep an article as unread
      #
      # @see mark_articles_as_unread
      # @param article_id [String]
      # @return [Feedlr::Success]
      def mark_article_as_unread(article_id)
        mark_articles_as_unread([article_id])
      end

      # Keep multiple articles as unread
      #
      # @see http://developer.feedly.com/v3/markers/#mark-one-or-multiple-articles-as-read
      # @param articles_ids [#to_ary]
      # @return [Feedlr::Success]
      def mark_articles_as_unread(articles_ids)
        build_object(method: :post, path: '/markers',
                     params: { entryIds: articles_ids.to_ary,
                               action: 'keepUnread',
                               type: 'entries' }
                     )
      end

      # Mark feeds as read
      #
      # @see mark_feeds_as_read
      # @param feed_id [String]
      # @param options [#to_hash]
      # @return [Feedlr::Success]
      def mark_feed_as_read(feed_id, options)
        mark_feeds_as_read([feed_id], options)
      end

      # Mark feeds as read
      #
      # @see http://developer.feedly.com/v3/markers/#mark-a-feed-as-read
      # @param feeds_ids [#to_ary]
      # @param options [#to_hash]
      # @option options [String] :lastReadEntryId
      # @option options [String] :asOf timestamp
      # @return [Feedlr::Success]
      def mark_feeds_as_read(feeds_ids, options)
        options = options.to_hash
        fail(ArgumentError) unless options[:lastReadEntryId] || options[:asOf]
        opts =  {
          feedIds: feeds_ids.to_ary,
          action: 'markAsRead',
          type: 'feeds'
        }
        opts[:lastReadEntryId] =
          options[:lastReadEntryId] if options[:lastReadEntryId]
        opts[:asOf] = options[:asOf] if options[:asOf]
        build_object(method: :post, path: '/markers', params: opts)
      end

      # Mark a category as read
      #
      # @see mark_categories_as_read
      # @param category_id [String]
      # @param options [#to_hash]
      # @return [Feedlr::Success]
      def mark_category_as_read(category_id, options)
        mark_categories_as_read([category_id], options)
      end

      # Mark categories as read
      #
      # @see http://developer.feedly.com/v3/markers/#mark-a-category-as-read
      # @param categories_ids [#to_ary]
      # @param options [#to_hash]
      # @option options [String] :lastReadEntryId
      # @option options [String] :asOf timestamp
      # @return [Feedlr::Success]
      def mark_categories_as_read(categories_ids, options)
        options = options.to_hash
        fail(ArgumentError) unless options[:lastReadEntryId] || options[:asOf]
        opts =  {
          categoryIds: categories_ids.to_ary,
          action: 'markAsRead',
          type: 'categories'
        }
        opts[:lastReadEntryId] =
          options[:lastReadEntryId] if options[:lastReadEntryId]
        opts[:asOf] = options[:asOf] if options[:asOf]
        build_object(method: :post, path: '/markers', params: opts)
      end

      # Undo mark a feed as read
      #
      # @see undo_mark_feeds_as_read
      # @param feed_id [String]
      # @return [Feedlr::Success]
      def undo_mark_feed_as_read(feed_id)
        undo_mark_feeds_as_read([feed_id])
      end

      # Undo mark feeds as read
      #
      # @see http://developer.feedly.com/v3/markers/#undo-mark-as-read
      # @param feeds_ids [#to_ary]
      # @return [Feedlr::Success]
      def undo_mark_feeds_as_read(feeds_ids)
        build_object(method: :post, path: '/markers',
                     params: { feedIds: feeds_ids.to_ary,
                               action: 'undoMarkAsRead',
                               type: 'feeds' }
                     )
      end

      # Undo Mark a category as read
      #
      # @see undo_mark_categories_as_read
      # @param category_id [String]
      # @return [Feedlr::Success]
      def undo_mark_category_as_read(category_id)
        undo_mark_categories_as_read([category_id])
      end

      # Undo mark categories as read
      #
      # @see http://developer.feedly.com/v3/markers/#undo-mark-as-read
      # @param categories_ids [#to_ary]
      # @return [Feedlr::Success]
      def undo_mark_categories_as_read(categories_ids)
        build_object(method: :post, path: '/markers',
                     params: { categoryIds: categories_ids.to_ary,
                               action: 'undoMarkAsRead',
                               type: 'categories' }
                     )
      end

      # Get the latest read operations (to sync local cache)
      #
      # @see http://developer.feedly.com/v3/markers/#get-the-latest-read-operations-to-sync-local-cache
      # @param options [#to_hash]
      # @option options [String] :newerThan timestamp in ms. Default is 30 days.
      # @return [Feedlr::Base]
      def sync_read_counts(options = {})
        build_object(method: :get, path: '/markers/reads', params: options)
      end

      # Get the latest tagged entry ids
      #
      # @see http://developer.feedly.com/v3/markers/#get-the-latest-tagged-entry-ids
      # @param options [#to_hash]
      # @option options [String] :newerThan timestamp in ms. Default is 30 days.
      # @return [Feedlr::Base]
      def lastest_tagged_entries(options = {})
        build_object(method: :get, path: '/markers/tags', params: options)
      end
    end
  end
end
