require "fileutils"
require "base64"

module Wikail
  class FileEngine
    EXCLUDE_DIRS = [".", "..", ".gitkeep"]

    def initialize(dir = Wikail::Environment::DATA_DIR)
      @dir = dir
      FileUtils.mkdir(@dir) unless File.exists?(@dir)
    end

    def execute(command, *args)
      command = command.to_s.delete ":"
      send(command, *args)
    end

    def title_to_filename(title)
      Base64.strict_encode64 title.strip.gsub(/[\t\n\r\f]/, "")
    end

    def filename_to_title(filename)
      Base64.strict_decode64 filename
    end

    def create(options)
      filename = File.join(@dir, title_to_filename(options[:args]))
      File.open(filename, "w") do |file|
        file.puts options[:body]
      end
    end

    def delete(options)
      FileUtils.rm File.join(@dir, title_to_filename(options[:args]))
      nil
    end

    def update(options)
      create options
    end

    def list(args = nil)
      files = Dir.entries(@dir) - EXCLUDE_DIRS
      documents = files.map { |file| filename_to_title(file) }
      str = "Documents:\n\n"
      str << documents.join("\n")
      str
    end

    def show(options)
      File.read File.join(@dir, title_to_filename(options[:args]))
    end
  end
end

