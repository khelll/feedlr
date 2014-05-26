module Feedlr
  # Gem's version
  class Version
    MAJOR = 0
    MINOR = 1
    PATCH = 0

    class << self
      # @return [String]
      def to_s
        [MAJOR, MINOR, PATCH].compact.join('.')
      end
    end
  end
end
