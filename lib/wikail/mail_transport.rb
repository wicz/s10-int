module Wikail
  class MailTransport
    def initialize
      configure
    end

    def configure
      Mail.defaults do
        retriever_method(
          :imap,
          address:    Wikail::Environment::IMAP_SERVER,
          port:       Wikail::Environment::IMAP_PORT,
          user_name:  Wikail::Environment::USERNAME,
          password:   Wikail::Environment::PASSWORD,
          enable_ssl: true
        )

        delivery_method(
          :smtp,
          address:        Wikail::Environment::SMTP_SERVER,
          port:           Wikail::Environment::SMTP_PORT,
          domain:         Wikail::Environment::SMTP_DOMAIN,
          user_name:      Wikail::Environment::USERNAME,
          password:       Wikail::Environment::PASSWORD,
          authentication: 'plain',
          enable_starttls_auto: true
        )
      end
    end

    def read
      Mail.all :delete_after_find => true
    end

    def deliver(to, subject, body)
      Mail.deliver do
        from    Wikail::Environment::USERNAME
        to      to
        subject subject
        body    body
      end
    end
  end
end