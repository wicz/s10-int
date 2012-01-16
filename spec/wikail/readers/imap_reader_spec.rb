require 'spec_helper'

describe Wikail::ImapReader do
  describe "#read" do
    it "can read from server" do
      reader = Wikail::ImapReader.new(Wikail.config.mail_transport)
      Mail.should_receive(:all)
      reader.read
    end
  end
end