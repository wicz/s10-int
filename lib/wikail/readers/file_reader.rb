module Wikail
    
  class FileReader
    def initialize(source)
      @source = (source == "-") ? ARGF.read : File.read(source)
    end
  
    def read
      Mail.read_from_string @source
    end
  end

end