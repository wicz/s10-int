module Wikail
  class Responder
    attr_reader :transport

    def initialize(transport = Wikail::Environment::MAIL_TRANSPORT.new)
      @transport = transport
    end

    def respond(to, subject, body)
      @transport.deliver to, subject, body
    end
  end
end