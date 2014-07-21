require 'delegate'
module Feedlr
  # When the response is of Array type,
  #  it creates an array of Feedlr::Base or plain types values
  class Collection < SimpleDelegator
    # Initializer
    # @param [Array] data
    # @return [Feedlr::Collection]
    def initialize(data = [])
      super([])
      data.each { |value| self << build_object(value) }
    end

    private

    def build_object(value)
      value.is_a?(Hash) ? Feedlr::Base.new(value) : value
    end
  end
end
