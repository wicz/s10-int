module Wikail
  class Parser
    InvalidEmailSyntax = Class.new(StandardError)

    COMMAND_REGEX = "(?<command>:[a-z]+)"
    ARGS_REGEX    = "(\s+(?<args>[^\n]*))?"
    BODY_REGEX    = "(\n+(?<body>^((?!\n:end).)*))?"

    def tokenize(message)
      body = message.body.decoded.strip
      tokens = body.match /#{COMMAND_REGEX}#{ARGS_REGEX}#{BODY_REGEX}/im
      tokens ? [tokens[:command], tokens[:args], tokens[:body]] : []
    end

    def parse(message)
      command, args, body = tokenize message
      raise InvalidEmailSyntax unless command
      {:command => command, :args => args, :body => body}
    end
  end
end

