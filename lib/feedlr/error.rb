require_relative 'rate_limit'

module Feedlr
  # Custom error class for rescuing from all Feedlr errors
  class Error < StandardError
    attr_reader :rate_limit

    class << self
      # @return [Hash]
      def errors
        @errors ||=  {
          400 => Feedlr::Error::BadRequest,
          401 => Feedlr::Error::Unauthorized,
          403 => Feedlr::Error::Forbidden,
          404 => Feedlr::Error::NotFound,
          500 => Feedlr::Error::InternalServerError
        }
      end
    end

    # Initializes a new Error object
    #
    # @param message [Exception, String]
    # @param rate_limit [Hash]
    # @return [Feedlr::Error]
    def initialize(message = '', rate_limit =  {})
      super(message)
      @rate_limit = Feedlr::RateLimit.new(rate_limit)
    end

    # Raised when Feedlr returns a 4xx HTTP status status_code
    class ClientError < self; end

    # Raised when Feedlr returns the HTTP status status_code 400
    class BadRequest < ClientError; end

    # Raised when Feedlr returns the HTTP status status_code 401
    class Unauthorized < ClientError; end

    # Raised when Feedlr returns the HTTP status status_code 403
    class Forbidden < ClientError; end

    # Raised when Feedlr returns the HTTP status status_code 404
    class NotFound < ClientError; end

    # Raised when Feedlr returns a 5xx HTTP status code
    class ServerError < self; end

    # Raised when Feedlr returns the HTTP status status_code 500
    class InternalServerError < ServerError; end

    # Raised when the request times out
    class RequestTimeout < self; end
  end
end
