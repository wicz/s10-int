module Wikail
  class MailTransport
    def initialize(username = Wikail.config.username, password = Wikail.config.password)
      @username = username
      @password = password
      configure
    end

    def configure
      Mail.defaults do
        retriever_method :pop3, address: "pop.gmail.com",
                                port: 995,
                                user_name: @username,
                                password: @password,
                                enable_ssl: true

        delivery_method :smtp, address: 'smtp.gmail.com',
                               port: 587,
                               user_name: @username,
                               password: @password,
                               authentication: 'plain',
                               enable_starttls_auto: true
      end
    end

    def read
      Mail.all
    end

    def deliver message, body
      Mail.deliver do
        from Wikail.config.username
        to message.from.first
        subject message.subject
        body body
      end
    end
  end
end