module Wikail
  class Pop3Reader
    def initialize(transport)
      @transport = transport.new
    end

    def read
      @transport.read
    end
  end
end