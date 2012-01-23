module Wikail
  class ImapReader
    attr_reader :transport

    def initialize(transport = Wikail::Environment::MAIL_TRANSPORT)
      @transport = transport
    end

    def messages
      @transport.read
    end
  end
end