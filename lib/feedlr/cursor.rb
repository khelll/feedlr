module Feedlr
  # Enumerable HTTP cursor
  class Cursor
    include Enumerable
    # Gets an enumerable cursor for an HTTP request
    # @param [Hash] request_attributes request options
    # @option request_attributes [Symbol] :method
    # @option request_attributes [String] :path
    # @option request_attributes [String] :params
    # @option request_attributes [String] :headers
    # @option request_attributes [String] :client
    # @return [Feedlr::Cursor]
    def initialize(request_attributes)
      self.request_attributes = request_attributes
      self.continuation = continuation_init_value
    end

    # Checks wheather this is the last page
    # @return [Boolean]
    def last_page?
      continuation.nil?
    end

    # Checks wheather this there is more pages
    # @return [Boolean]
    def next_page?
      !last_page?
    end

    # Returns the next page
    # @return [Feedlr::Base]
    def next_page
      return if last_page?
      response = perform_request
      object = Factory.create(response.body)
      self.continuation = object.continuation
      object
    end

    # Yields the subsequent page responses to a given block
    # @yieldparam [Feedlr::Base] response
    # @return [Enumerable, nil]
    def each_page
      return to_enum(__callee__) unless block_given?
      yield(next_page) until last_page?
    end

    alias_method :each, :each_page

    private

    attr_accessor :continuation, :request_attributes

    def pagenated_request_attributes
      request_params = request_attributes[:params]
      if continuation != continuation_init_value
        request_params = request_params.update(continuation: continuation)
      end
      request_attributes.merge(params: request_params)
    end

    def continuation_init_value
      -1
    end

    def perform_request
      Request.new(pagenated_request_attributes).perform
    end
  end
end
