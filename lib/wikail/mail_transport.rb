module Wikail
  class MailTransport
    def initialize(username = Wikail.config.username, password = Wikail.config.password)
      configure username, password
    end

    def configure user, pass
      Mail.defaults do
        retriever_method :imap, address: "imap.gmail.com",
                                port: 993,
                                user_name: user,
                                password: pass,
                                enable_ssl: true

        delivery_method :smtp, address: 'smtp.gmail.com',
                               port: 587,
                               domain: 'gmail.com',
                               user_name: user,
                               password: pass,
                               authentication: 'plain',
                               enable_starttls_auto: true
      end
    end

    def read
      Mail.all :delete_after_find => true
    end

    def deliver to, subject, body
      Mail.deliver do
        from    Wikail.config.username
        to      to
        subject subject
        body    body
      end
    end
  end
end