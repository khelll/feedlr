require 'forwardable'
require_relative 'response'
require_relative 'error'

module Feedlr
  # Wrap request attrs
  class Request
    extend Forwardable
    def_delegators :client, :logger, :connection

    # Initializer
    # @param [Hash] attrs request attributes
    # @option attrs [Feedlr::Client] :client
    # @option attrs [Symbol] :method
    # @option attrs [String] :path
    # @option attrs [Hash] :params
    # @option attrs [Hash] :headers
    # @return [Feedlr::Request]
    def initialize(attrs)
      self.client = attrs.fetch(:client)
      self.method = attrs.fetch(:method)
      self.path = attrs.fetch(:path)
      self.headers = attrs.fetch(:headers) { {} }
      self.params = attrs.fetch(:params) { {} }
    end

    # Run the desired HTTP request and raise excpetions in
    # case of failure, otherwise return the response
    # @return [Feedlr::Response]
    def perform
      response = run_and_log
      response.raise_http_errors
      response
    rescue Faraday::Error::TimeoutError, Timeout::Error => error
      raise(Feedlr::Error::RequestTimeout.new, error.message)
    rescue Faraday::Error::ClientError, JSON::ParserError => error
      raise(Feedlr::Error.new, error.message)
    end

    private

    attr_accessor :headers, :method, :client, :path, :params


    # Run, log and wrap the request
    # @return [Feedlr::Response]
    def run_and_log
      faraday_response = run
      logger.debug(faraday_response.inspect)
      Feedlr::Response.new(faraday_response.status.to_i,
                           faraday_response.headers,
                           faraday_response.body)
    end

    # Run the actual request
    # @return [Faraday::Response]
    def run
      connection.send(method) do |request|
        request.url(client.class::API_VERSION + path)
        request.headers.update(headers)
        faraday_params(request)
      end
    end

    def faraday_params(request)
      return unless params
      if [:post, :put].include? method
        request.body = payload
      else
        request.params.update(params_to_hash)
      end
    end

    # Gets payload for POST/PUT requests
    # If content-type header is set, then it's xml request
    def payload
      if headers[:"Content-Type"]
        params
      else
        MultiJson.dump(params_to_payload)
      end
    end

    # Convert params to consumable payload
    # @return [Hash,Array]
    def params_to_payload
      case params
      when ->(data) { data.respond_to?(:to_hash) }
        params.to_hash
      when ->(data) { data.respond_to?(:to_ary) }
        params.to_ary
      else
        fail TypeError, "#{params.inspect} to payload"
      end
    end

    # Convert params to consumable hash
    # @return [Hash]
    def params_to_hash
      case params
      when ->(data) { data.respond_to?(:to_hash) }
        params.to_hash
      else
        fail TypeError, "#{params.inspect} to params"
      end
    end

  end
end
