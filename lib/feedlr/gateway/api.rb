require_relative 'feeds'
require_relative 'categories'
require_relative 'entries'
require_relative 'markers'
require_relative 'subscriptions'
require_relative 'tags'
require_relative 'topics'
require_relative 'shorten'
require_relative 'profile'
require_relative 'preferences'
require_relative 'streams'
require_relative 'opml'
require_relative 'search'
require_relative 'mixes'
require_relative 'facebook'
require_relative 'twitter'
require_relative 'microsoft'
require_relative 'evernote'

module Feedlr
  module Gateway
    # include all needed gateways
    module API
      include Feeds
      include Categories
      include Entries
      include Streams
      include Markers
      include Subscriptions
      include Tags
      include Topics
      include Shorten
      include Profile
      include Preferences
      include Mixes
      include Opml
      include Search
      include Facebook
      include Twitter
      include Microsoft
      include Evernote
    end
  end
end
