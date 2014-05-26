require_relative 'rate_limit'

module Feedlr
  # Custom error class for rescuing from all Feedlr errors
  class Error < StandardError
    attr_reader :rate_limit

    class << self
      # Create a new error from an HTTP response
      #
      # @param response [Faraday::Response]
      # @return [Feedlr::Error]
      def from_response(response)
        status_code = response.status.to_i
        message = parse_error(status_code, response.body)
        new(message, response.headers)
      end

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

      private

      def parse_error(status, body)
        if body.is_a?(Hash)
          if body['errorMessage']
            "Error #{status} - #{body['errorMessage']}"
          else
            "Error #{status}"
          end
        else
          "Error #{status} - #{body}"
        end
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

    # Raised when Twitter returns a 5xx HTTP status code
    class ServerError < self; end

    # Raised when Feedlr returns the HTTP status status_code 500
    class InternalServerError < ServerError; end

    # Raised when the request times out
    class RequestTimeout < self; end
  end
end
