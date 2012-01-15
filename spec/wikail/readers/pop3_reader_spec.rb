require 'spec_helper'

describe Wikail::Pop3Reader do
  describe "#read" do
    it "can read from server" do
      reader = Wikail::Pop3Reader.new(Wikail.config.mail_transport)
      reader.read.should be_empty
    end
  end
end