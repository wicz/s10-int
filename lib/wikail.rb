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

module Wikail
  extend self

  def config
    @config ||= OpenStruct.new({
      :engine => Wikail::FileEngine,
      :mail_transport => Wikail::MailTransport,
      :data_dir => File.expand_path('../../data', __FILE__),
      :username => '',
      :password => ''
    })
  end

  def process reader
    # reader = Reader.new(:file, '/Users/vinicius/Projects/rmu/s10-int/basic_email.eml')
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