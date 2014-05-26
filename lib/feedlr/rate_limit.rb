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
    def initialize(attrs =  {})
      @count =
        attrs['x-ratelimit-count'].to_i if attrs['x-ratelimit-count']
      @limit =
        attrs['x-ratelimit-limit'].to_i if attrs['x-ratelimit-limit']
      @remaining =
        attrs['x-ratelimit-remaining'].to_i if attrs['x-ratelimit-remaining']
    end
  end
end
