require_relative '../lib/wikail'

Mail.defaults do
  delivery_method :test
  retriever_method :test
end