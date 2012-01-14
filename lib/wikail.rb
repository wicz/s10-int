require 'mail'

module Wikail
  
  class Reader
    def messages
      [Mail.read(File.expand_path('../../data/basic_email.eml', __FILE__))]
    end
  end
  
  class Parser
    def parse message
      tokens = tokenize message
      command, body = tokens.first, tokens.last
      raise unless command
      {:command => command, :body => body}
    end
    
    def tokenize message
      tokens = message.body.decoded.strip.match /(:[a-z]+)([^:end]*)/
      tokens.to_a[1..-1]
    end
  end
  
  class Backend
    def execute command
      command = command.to_s.delete ':'
      raise unless self.respond_to? command
      self.send command
    end
    
    def list
      "Available articles:"
    end
  end
  
  class Responder
    def deliver to, body
      puts "Sending \"#{body}\" to #{to}"
    end
  end
  
  def self.process
    reader = Reader.new
    parser = Parser.new
    backend = Backend.new
    responder = Responder.new
    reader.messages.each do |msg|
      options = parser.parse msg
      response = backend.execute(options[:command])
      responder.deliver msg.from, response
    end
    true
  end

end