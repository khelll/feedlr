require 'hashie'
require 'multi_json'
require_relative 'base'
require_relative 'collection'
require_relative 'success'

module Feedlr
  # The generalized pseudo-object that is returned for all query
  # requests.
  # http://martinfowler.com/eaaCatalog/dataMapper.html
  class Mapper
    # Build the proper object depending on the response
    # @return [Feedlr::Base, Feedlr::Success, Feedlr::Collection]
    def self.build(data)
      case data
      when Hash
        (data.size > 0) ? Feedlr::Base.new(data) : Feedlr::Success.new
      when Array
        Feedlr::Collection.new(data)
      else
        Feedlr::Success.new
      end
    end
  end
end
