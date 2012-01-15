module Wikail
  class Responder
    attr_reader :transport

    def initialize(transport = Wikail.config.mail_transport)
      @transport = transport
    end

    def respond message, body
      @transport.deliver do
        from Wikail.config.from_address
        to message.from.first
        body body
      end
    end
  end
end