require_relative 'http'
require_relative 'utils'
require_relative 'gateway/api'

module Feedlr
  # Feedlr Client
  class Client
    include HTTP
    include Utils
    include Gateway::API
    attr_reader :oauth_access_token, :oauth_refresh_token, :sandbox, :logger

    # Initializer
    # @param [Hash] options client options
    # @option options [String] :oauth_access_token
    # @option options [Boolean] :sandbox
    # @option options [#debug,#info] :logger
    # @return [Feedlr::Client]
    def initialize(options = {})
      self.oauth_access_token = options.fetch(:oauth_access_token) do
        Feedlr.oauth_access_token
      end
      self.oauth_refresh_token = options.fetch(:oauth_refresh_token) do
        Feedlr.oauth_refresh_token
      end
      self.logger = options.fetch(:logger) { Feedlr.logger }
      self.sandbox = options.fetch(:sandbox) { Feedlr.sandbox }
    end

    def refresh_oauth_token
      params = {
        refresh_token: oauth_refresh_token,
        client_id: "feedlydev",
        client_secret: "feedlydev",
        grant_type: "refresh_token",
      }
      Request.new(
        client: self,
        method: :post,
        path: "/auth/token",
        params: params
      ).perform
    end

    # Sandbox factory
    # @param [Hash] options client options
    # @option options [String] :oauth_access_token
    # @option options [#debug,#info] :logger
    # @return [Feedlr::Client]
    def self.sandbox(options = {})
      new(options.merge(sandbox: true))
    end

    alias sandbox? sandbox

    private

    attr_writer :logger, :oauth_access_token, :oauth_refresh_token

    def sandbox=(value)
      @sandbox = boolean(value)
    end
  end
end
