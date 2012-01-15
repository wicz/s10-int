module Wikail
  class Responder
    attr_reader :transport

    def initialize(transport = Wikail.config.mail_transport)
      @transport = transport.new
    end

    def respond message, body
      @transport.deliver message, body
    end
  end
end