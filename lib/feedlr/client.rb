require_relative 'request'
require_relative 'utils'
require_relative 'gateway/feeds'
require_relative 'gateway/categories'
require_relative 'gateway/entries'
require_relative 'gateway/markers'
require_relative 'gateway/subscriptions'
require_relative 'gateway/tags'
require_relative 'gateway/topics'
require_relative 'gateway/shorten'
require_relative 'gateway/profile'
require_relative 'gateway/preferences'
require_relative 'gateway/streams'
require_relative 'gateway/opml'
require_relative 'gateway/search'
require_relative 'gateway/mixes'
require_relative 'gateway/facebook'
require_relative 'gateway/twitter'
require_relative 'gateway/microsoft'
require_relative 'gateway/evernote'

module Feedlr
  # Feedlr Client
  class Client
    include Request
    include Utils
    include Gateway::Feeds
    include Gateway::Categories
    include Gateway::Entries
    include Gateway::Streams
    include Gateway::Markers
    include Gateway::Subscriptions
    include Gateway::Tags
    include Gateway::Topics
    include Gateway::Shorten
    include Gateway::Profile
    include Gateway::Preferences
    include Gateway::Mixes
    include Gateway::Opml
    include Gateway::Search
    include Gateway::Facebook
    include Gateway::Twitter
    include Gateway::Microsoft
    include Gateway::Evernote

    attr_reader :oauth_access_token, :sandbox, :logger

    # Initializer
    # @param [Hash] options client options
    # @option options [String] :oauth_access_token
    # @option options [Boolean] :sandbox
    # @option options [#debug,#info] :logger
    # @return [Feedlr::Client]
    def initialize(options = {})
      @oauth_access_token = options.fetch(:oauth_access_token) do
        Feedlr.oauth_access_token
      end
      @logger = options.fetch(:logger) { Feedlr.logger }
      self.sandbox = options.fetch(:sandbox) { Feedlr.sandbox }
    end

    # Sandbox factory
    # @param [Hash] options client options
    # @option options [String] :oauth_access_token
    # @option options [#debug,#info] :logger
    # @return [Feedlr::Client]
    def self.sandbox(options = {})
      new(options.merge(sandbox: true))
    end

    alias_method :sandbox?, :sandbox

    private

    def sandbox=(value)
      @sandbox = boolean(value)
    end
  end
end
