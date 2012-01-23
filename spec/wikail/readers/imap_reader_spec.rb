require 'spec_helper'

describe Wikail::ImapReader do
  describe "#messages" do
    it "reads from server" do
      reader = Wikail::ImapReader.new(Wikail::Environment::MAIL_TRANSPORT)
      Mail.should_receive(:all)
      reader.messages
    end
  end
end