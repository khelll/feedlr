module Feedlr
  # Wrap request attrs
  class Request

    # Initializer
    # @param [Hash] attrs request attributes
    # @option attrs [Feedlr::Client] :client
    # @option attrs [Symbol] :method
    # @option attrs [String] :path
    # @option attrs [Hash] :params
    # @option attrs [Hash] :headers
    # @return [Feedlr::Request]
    def initialize(attrs)
      @client = attrs.fetch(:client)
      @method = attrs.fetch(:method)
      @path = attrs.fetch(:path)
      @params = attrs.fetch(:params) { nil }
      @headers = attrs.fetch(:headers) { nil }
    end

    # Perform the request
    # @return [Feedlr::Response]
    def perform
      @client.send(@method, @path, @params, @headers)
    end
  end
end
