module Feedlr
  # Rate limiting object associated with responses
  class RateLimit
    attr_reader :count, :limit, :remaining
    # Initializes a new object
    #
    # @param attrs [Hash]
    # @option attrs [String] :x-ratelimit-count
    # @option attrs [String] :x-ratelimit-limit
    # @option attrs [String] :x-ratelimit-remaining
    # @return [Feedlr::RateLimit]
    def initialize(attrs = {})
      @count = get_value(attrs['x-ratelimit-count'])
      @limit = get_value(attrs['x-ratelimit-limit'])
      @remaining = get_value(attrs['x-ratelimit-remaining'])
    end

    private

    def get_value(value)
      value.to_i if value
    end
  end
end
