module Wikail
  class FileEngine < Engine
    EXCLUDE_DIRS = ['.', '..']

    def initialize
      @dir = Wikail.config.data_dir
    end

    def create options
      filename = File.join(@dir, title_to_filename(options[:args]))
      File.open(filename, "w") do |file|
        file.puts options[:body]
      end
    end

    def list(args = nil)
      files = Dir.entries(@dir) - EXCLUDE_DIRS
      documents = files.map { |file| filename_to_title(file) }
      str = "Documents:\n"
      str << documents.join('\n')
      str
    end

    def show options
      File.read File.join(@dir, title_to_filename(options[:args]))
    end
  end
end