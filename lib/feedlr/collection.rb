require 'delegate'
module Feedlr
  # When the response is of Array type,
  #  it creates an array of Feedlr::Base or plain types elements
  class Collection < SimpleDelegator
    # Initializer
    # @param [Array] data
    # @return [Feedlr::Collection]
    def initialize(data = [])
      super([])
      data.each do |e|
        self.<<(e.is_a?(Hash) ? Feedlr::Base.new(e) : e)
      end
    end
  end
end
