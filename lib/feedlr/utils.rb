module Feedlr
  # Utilities
  module Utils
    module_function

    # Read file contents
    #
    # @param content [#to_str, #read]
    # @return [String]
    def read_file_contents(file)
      if file.respond_to?(:to_str)
        File.open(file, 'rb') { |f| f.read }
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
