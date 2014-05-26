module Feedlr
  # Tagging class to indicate a success in requests that have
  #  2xx response code and an empty body
  class Success < Feedlr::Base; end
end
