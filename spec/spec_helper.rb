require_relative "../lib/wikail"

module Wikail
  module Environment
    DATA_DIR = File.expand_path("../data", __FILE__)
  end
end

Mail.defaults do
  delivery_method :test
  retriever_method :test
end

