module Wikail
  class Responder
    attr_reader :transport

    def initialize(transport = Wikail.config.mail_transport)
      @transport = transport.new
    end

    def respond(to, subject, body)
      @transport.deliver to, subject, body
    end
  end
end