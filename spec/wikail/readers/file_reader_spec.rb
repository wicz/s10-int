require 'spec_helper'

describe Wikail::FileReader do

  let(:file_path) { File.expand_path('../../../fixtures/basic_email.eml', __FILE__) }

  describe "#new" do
    it "read file contents" do
      File.should_receive :read
      Wikail::FileReader.new(file_path)
    end

    it "read from stdin" do
      ARGF.should_receive :read
      Wikail::FileReader.new('-')
    end
  end

  describe "#messages" do
    it "return the message in an array" do
      reader = Wikail::FileReader.new(file_path)
      reader.messages.should be_a(Array)
      reader.messages.first.should be_a(Mail::Message)
    end
  end
end