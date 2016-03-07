module Feedlr
  # Utilities
  module Utils
    module_function

    # Join ids
    # @param file [#to_int]
    # @return [String]
    def join_ids(ids)
      ids.to_ary.map { |id| CGI.escape(id) }.join(',')
    end

    # Read file contents
    #
    # @param file [#to_str, #read]
    # @return [String]
    def read_file_contents(file)
      if file.respond_to?(:to_str)
        File.open(file, 'rb', &:read)
      else
        file.read
      end
    end

    # Get boolean value
    #
    # @param content [FalseClass,TrueClass]
    # @return [FalseClass,TrueClass]
    def boolean(value)
      fail(TypeError) unless [true, false].include?(value)
      value
    end
  end
end
