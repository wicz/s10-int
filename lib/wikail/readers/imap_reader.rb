module Wikail
  class ImapReader
    attr_reader :transport

    def initialize(transport)
      @transport = transport.new
    end

    def read
      @transport.read
    end
  end
end