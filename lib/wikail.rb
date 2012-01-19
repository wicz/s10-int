require 'mail'
require 'ostruct'

require_relative 'wikail/reader'
require_relative 'wikail/parser'
require_relative 'wikail/engine'
require_relative 'wikail/responder'
require_relative 'wikail/mail_transport'

require_relative 'wikail/readers/file_reader'
require_relative 'wikail/readers/imap_reader'

require_relative 'wikail/engines/file_engine'

require_relative '../config/environment'

module Wikail
  extend self

  def process(reader)
    parser = Parser.new
    engine = Engine.new
    responder = Responder.new
    reader.messages.each do |msg|
      to = msg.from.first
      begin
        options = parser.parse msg
        command = options.delete :command
        response = engine.execute(command, options)
        responder.respond to, "[wikail] #{command}", response if response
      rescue Exception => e
        responder.respond to, '[wikail] error', e.message
      end
    end
  end
end