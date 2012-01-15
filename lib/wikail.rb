require 'mail'
require 'ostruct'

require_relative 'wikail/reader'
require_relative 'wikail/parser'
require_relative 'wikail/engine'
require_relative 'wikail/responder'
require_relative 'wikail/mail_transport'

require_relative 'wikail/readers/file_reader'
require_relative 'wikail/readers/pop3_reader'

require_relative 'wikail/engines/file_engine'

module Wikail
  extend self

  def config
    @config ||= OpenStruct.new({
      :engine => Wikail::FileEngine,
      :mail_transport => Wikail::MailTransport,
      :data_dir => '/Users/vinicius/Projects/rmu/s10-int/data',
      :username => '',
      :password => ''
    })
  end

  def process
    reader = Reader.new(:file, '/Users/vinicius/Projects/rmu/s10-int/basic_email.eml')
    # reader = Reader.new(:pop3, Wikail.config.mail_transport)
    parser = Parser.new
    engine = Engine.new
    responder = Responder.new
    reader.messages.each do |msg|
      options = parser.parse msg
      response = engine.execute(options[:command], options.reject! { |k,v| k == :command })
      responder.respond msg, response
    end
    true
  end
end

Wikail.config
Wikail.process