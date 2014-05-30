module Feedlr
  # Utilities
  module Utils
    private

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
  end
end
