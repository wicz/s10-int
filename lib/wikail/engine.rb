require 'base64'

module Wikail
  class Engine
    attr_reader :engine

    def initialize(engine = Wikail::Environment::ENGINE.new)
      @engine = engine
    end

    def execute(command, *args)
      command = command.to_s.delete ':'
      @engine.send command, *args
    end

    def title_to_filename(title)
      Base64.strict_encode64 title.strip.gsub(/[\t\n\r\f]/, '')
    end

    def filename_to_title(filename)
      Base64.strict_decode64 filename
    end
  end
end