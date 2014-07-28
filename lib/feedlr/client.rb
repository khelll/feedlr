require_relative 'http'
require_relative 'request'
require_relative 'utils'
require_relative 'gateway/api'

module Feedlr
  # Feedlr Client
  class Client
    include HTTP
    include Utils
    include Gateway::API
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
