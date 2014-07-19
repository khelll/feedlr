module Feedlr
  # wrapper for Faraday response
  class Response
    attr_reader :status, :body, :headers
    # Initializes a new response object
    # @param status [#to_int]
    # @param headers [#to_hash]
    # @param body [String, Hash, Array]
    def initialize(status, headers, body)
      @status = status.to_int
      @headers = headers.to_hash
      @body = body
    end

    # Check the response code and raise exceptions if needed
    # @return [void]
    def raise_http_errors
      error_class = Feedlr::Error.errors[status]
      fail(error_class.new(error_message, headers)) if error_class
    end

    # Generates the error message when available
    def error_message
      @error_message ||= if body.is_a?(Hash)
        error_message = body['errorMessage']
        if error_message
          "Error #{status} - #{error_message}"
        else
          "Error #{status}"
        end
      else
        "Error #{status} - #{body}"
      end
    end
  end
end
