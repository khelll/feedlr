require 'faraday'
require 'faraday_middleware'
require_relative 'request'
require_relative 'factory'
require_relative 'cursor'

module Feedlr
  # Do all http requests and call the mapper
  module HTTP
    ENDPOINT = 'http://cloud.feedly.com'.freeze
    SANDBOX_ENDPOINT = 'http://sandbox.feedly.com'.freeze
    API_VERSION = '/v3'.freeze

    private

    # Initiate and memoize the HTTP connection object
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(end_point, connection_options)
    end

    # Run an HTTP request and map the response to a domain class
    # @param [Hash] request_attributes request options
    # @option request_attributes [Symbol] :method
    # @option request_attributes [String] :path
    # @option request_attributes [String] :params
    # @option request_attributes [String] :headers
    # @return [Feedlr::Base, Feedlr::Success, Feedlr::Collection]
    def request_with_object(request_attributes)
      request_attributes = request_attributes.merge(client: self)
      response = Request.new(request_attributes).perform
      Factory.create(response.body)
    end

    # Gets an enumerable cursor for an HTTP request
    # @param [Hash] request_attributes request options
    # @option request_attributes [Symbol] :method
    # @option request_attributes [String] :path
    # @option request_attributes [String] :params
    # @option request_attributes [String] :headers
    # @return [Faraday::Cursor]
    def request_with_cursor(request_attributes)
      request_attributes = request_attributes.merge(client: self)
      Feedlr::Cursor.new(request_attributes)
    end

    # Build and memoize the connection options
    # @return [Hash]
    def connection_options
      @connection_options ||= {
        builder: middleware,
        headers: initial_headers,
        request:  {
          open_timeout: 10,
          timeout: 30
        }
      }
    end

    # Build the rack middleware for the requests
    # @return [Faraday::RackBuilder]
    def middleware
      Faraday::RackBuilder.new do |faraday|
        faraday.request :url_encoded
        # Add logging
        faraday.response(:logger, logger)
        # Parse XML
        faraday.response :xml, content_type: /\bxml$/
        # Parse JSON
        faraday.response :json, content_type: /\bjson$/

        faraday.adapter :net_http
      end
    end

    # Build the initial request headers
    # @return [Hash]
    def initial_headers
      @headers = { :Accept => 'application/json',
                   :"Content-Type" => 'application/json',
                   :user_agent => user_agent
                   }
      @headers[:Authorization] =
        "OAuth #{oauth_access_token}" if oauth_access_token
      @headers
    end

    # Build and memoize the user agent
    # @return [String]
    def user_agent
      @user_agent ||= "Feedlr Ruby Gem #{Feedlr::Version}"
    end

    # Build and memoize the endpoint
    # @return [String]
    def end_point
      @end_point ||= (sandbox ? SANDBOX_ENDPOINT : ENDPOINT)
    end
  end
end
