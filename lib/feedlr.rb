require_relative 'feedlr/version'
require_relative 'feedlr/client'
require_relative 'feedlr/null_logger'

# Feedlr top level module
module Feedlr
  class << self
    attr_accessor :oauth_access_token, :oauth_refresh_token
    attr_writer :sandbox, :logger

    # config/initializers/Feedlr.rb (for instance)
    #
    # ```ruby
    # Feedlr.configure do |config|
    #   config.oauth_access_token = 'oauth_access_token'
    #   config.sandbox = true
    #   config.logger = SomeCustomLogger.new
    # end
    # ```
    # elsewhere
    #
    # ```ruby
    # client = Feedlr::Client.new
    # ```

    def configure
      yield self
      true
    end

    # Sandbox setter
    def sandbox=(value)
      @sandbox = Feedlr::Utils.boolean(value)
    end

    # Returns the value of attribute sandbox
    def sandbox
      @sandbox ||= false
    end

    def logger
      @logger ||= NullLogger.new
    end
  end
end
