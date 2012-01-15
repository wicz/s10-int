module Wikail
  class Reader
    attr_reader :adapter
    
    def initialize(type, source)
      @adapter = Wikail.const_get("#{type.to_s.capitalize}Reader").new(source)
    end
    
    def messages
      Array(@adapter.read)
    end
  end
end